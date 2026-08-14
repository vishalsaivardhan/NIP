import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nip/core/config/app_theme.dart';

class ReceiveScreen extends ConsumerWidget {
  const ReceiveScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Receive Payment')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Merchant Icon
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: AppTheme.meshGateway.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppTheme.meshGateway.withValues(alpha: 0.3),
                    width: 2,
                  ),
                ),
                child: const Icon(
                  Icons.storefront_rounded,
                  size: 48,
                  color: AppTheme.meshGateway,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Ready to Receive',
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Your device is visible to nearby customers.\n'
                'Incoming payments will appear here.',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),

              // Status indicators
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      _StatusRow(
                        icon: Icons.bluetooth_rounded,
                        label: 'BLE Advertising',
                        value: 'Not Started',
                        color: AppTheme.offline,
                        theme: theme,
                      ),
                      const Divider(height: 24),
                      _StatusRow(
                        icon: Icons.devices_rounded,
                        label: 'Visible to Devices',
                        value: '0 nearby',
                        color: AppTheme.offline,
                        theme: theme,
                      ),
                      const Divider(height: 24),
                      _StatusRow(
                        icon: Icons.receipt_rounded,
                        label: 'Pending Payments',
                        value: '0',
                        color: colorScheme.primary,
                        theme: theme,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              FilledButton.icon(
                onPressed: () {
                  // TODO: Start BLE advertising as merchant
                },
                icon: const Icon(Icons.bluetooth_searching_rounded),
                label: const Text('Start Receiving'),
                style: FilledButton.styleFrom(minimumSize: const Size(200, 52)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatusRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;
  final ThemeData theme;

  const _StatusRow({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
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
