import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nip/core/constants/app_constants.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  bool _darkMode = false;
  String _nodeType = 'Customer';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: [
          // Node Configuration
          _SectionHeader('Node Configuration', theme),
          ListTile(
            leading: const Icon(Icons.person_rounded),
            title: const Text('Node Type'),
            subtitle: Text(_nodeType),
            trailing: const Icon(Icons.chevron_right_rounded),
            onTap: () => _showNodeTypeSelector(context),
          ),
          ListTile(
            leading: const Icon(Icons.fingerprint_rounded),
            title: const Text('Device Identity'),
            subtitle: const Text('Not generated'),
            trailing: const Icon(Icons.chevron_right_rounded),
            onTap: () {},
          ),

          const Divider(),
          _SectionHeader('Appearance', theme),
          SwitchListTile(
            secondary: const Icon(Icons.dark_mode_rounded),
            title: const Text('Dark Mode'),
            subtitle: const Text('Toggle dark theme'),
            value: _darkMode,
            onChanged: (value) => setState(() => _darkMode = value),
          ),

          const Divider(),
          _SectionHeader('Bluetooth', theme),
          ListTile(
            leading: const Icon(Icons.bluetooth_rounded),
            title: const Text('BLE Settings'),
            subtitle: const Text('Scan timeout, advertising interval'),
            trailing: const Icon(Icons.chevron_right_rounded),
            onTap: () {},
          ),

          const Divider(),
          _SectionHeader('Security', theme),
          ListTile(
            leading: const Icon(Icons.shield_rounded),
            title: const Text('Security Dashboard'),
            subtitle: const Text('View encryption & key status'),
            trailing: const Icon(Icons.chevron_right_rounded),
            onTap: () => context.push('/security'),
          ),
          ListTile(
            leading: const Icon(Icons.money_off_rounded),
            title: const Text('Offline Spending Limit'),
            subtitle: Text('₹${AppConstants.defaultOfflineLimit.toInt()}'),
            trailing: const Icon(Icons.chevron_right_rounded),
            onTap: () {},
          ),

          const Divider(),
          _SectionHeader('Demo', theme),
          ListTile(
            leading: const Icon(Icons.science_rounded),
            title: const Text('Demo Mode'),
            subtitle: const Text('Test 4-device mesh scenario'),
            trailing: const Icon(Icons.chevron_right_rounded),
            onTap: () => context.push('/demo'),
          ),

          const Divider(),
          _SectionHeader('About', theme),
          ListTile(
            leading: const Icon(Icons.info_outline_rounded),
            title: const Text('About ProxiUPI'),
            subtitle: const Text('Version ${AppConstants.appVersion}'),
            onTap: () {
              showAboutDialog(
                context: context,
                applicationName: AppConstants.appName,
                applicationVersion: AppConstants.appVersion,
                applicationLegalese:
                    'Secure Offline Proximity Payment Mesh\n\n'
                    'This is a PROTOTYPE. It does not process real payments, '
                    'connect to real bank accounts, or access production UPI infrastructure.\n\n'
                    '© 2026 NIP Project',
              );
            },
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  void _showNodeTypeSelector(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (final type in ['Customer', 'Merchant', 'Relay', 'Gateway'])
            ListTile(
              title: Text(type),
              leading: Radio<String>(
                value: type,
                // ignore: deprecated_member_use
                groupValue: _nodeType,
                // ignore: deprecated_member_use
                onChanged: (value) {
                  setState(() => _nodeType = value!);
                  Navigator.pop(context);
                },
              ),
              onTap: () {
                setState(() => _nodeType = type);
                Navigator.pop(context);
              },
            ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final ThemeData theme;

  const _SectionHeader(this.title, this.theme);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
      child: Text(
        title,
        style: theme.textTheme.labelLarge?.copyWith(
          color: theme.colorScheme.primary,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
