import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nip/core/config/app_theme.dart';

class GatewayScreen extends ConsumerWidget {
  const GatewayScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Gateway')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Gateway Status
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: AppTheme.meshGateway.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.cell_tower_rounded,
                      size: 40,
                      color: AppTheme.meshGateway,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Gateway Mode',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Bridge between mesh network and backend',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Gateway capabilities
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Gateway Status',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _GatewayStatusRow(
                    icon: Icons.wifi_rounded,
                    label: 'Internet Connection',
                    value: 'Not Available',
                    isAvailable: false,
                    theme: theme,
                  ),
                  const Divider(height: 24),
                  _GatewayStatusRow(
                    icon: Icons.bluetooth_rounded,
                    label: 'BLE Active',
                    value: 'Ready',
                    isAvailable: true,
                    theme: theme,
                  ),
                  const Divider(height: 24),
                  _GatewayStatusRow(
                    icon: Icons.cloud_upload_rounded,
                    label: 'Pending Uploads',
                    value: '0 transactions',
                    isAvailable: true,
                    theme: theme,
                  ),
                  const Divider(height: 24),
                  _GatewayStatusRow(
                    icon: Icons.cloud_download_rounded,
                    label: 'Last Sync',
                    value: 'Never',
                    isAvailable: false,
                    theme: theme,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Actions
          FilledButton.icon(
            onPressed: null, // Disabled until internet available
            icon: const Icon(Icons.sync_rounded),
            label: const Text('Sync with Backend'),
            style: FilledButton.styleFrom(
              minimumSize: const Size.fromHeight(52),
            ),
          ),
          const SizedBox(height: 12),
          OutlinedButton.icon(
            onPressed: () {
              // TODO: Toggle gateway mode
            },
            icon: const Icon(Icons.cell_tower_rounded),
            label: const Text('Enable Gateway Mode'),
            style: OutlinedButton.styleFrom(
              minimumSize: const Size.fromHeight(52),
            ),
          ),
          const SizedBox(height: 24),

          // Sync queue info
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Synchronization Queue',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Transactions waiting to be uploaded to the backend '
                    'for verification and settlement.',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: colorScheme.surfaceContainerLowest,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'Queue is empty',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: colorScheme.outline,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _GatewayStatusRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final bool isAvailable;
  final ThemeData theme;

  const _GatewayStatusRow({
    required this.icon,
    required this.label,
    required this.value,
    required this.isAvailable,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    final color = isAvailable ? AppTheme.success : AppTheme.offline;
    return Row(
      children: [
        Icon(icon, color: color, size: 22),
        const SizedBox(width: 12),
        Expanded(child: Text(label, style: theme.textTheme.bodyMedium)),
        Text(
          value,
          style: theme.textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.w600,
            color: color,
          ),
        ),
      ],
    );
  }
}
