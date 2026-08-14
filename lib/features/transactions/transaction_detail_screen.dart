import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nip/core/config/app_theme.dart';

class TransactionDetailScreen extends ConsumerWidget {
  final String transactionId;

  const TransactionDetailScreen({super.key, required this.transactionId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Transaction Detail')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Amount & Status
          Card(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  Text(
                    '₹100.00',
                    style: theme.textTheme.displaySmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Chip(
                    label: const Text('PENDING SETTLEMENT'),
                    backgroundColor: AppTheme.pending.withValues(alpha: 0.1),
                    side: BorderSide(
                      color: AppTheme.pending.withValues(alpha: 0.3),
                    ),
                    labelStyle: theme.textTheme.labelSmall?.copyWith(
                      color: AppTheme.pending,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'SIMULATED PAYMENT',
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: colorScheme.outline,
                      letterSpacing: 1,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Details
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Transaction Details',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _DetailRow('Transaction ID', transactionId, theme),
                  _DetailRow('Sender', 'Device-XXXX', theme),
                  _DetailRow('Receiver', 'Device-YYYY', theme),
                  _DetailRow('Amount', '₹100.00', theme),
                  _DetailRow('Time', 'Aug 14, 2026 03:30 PM', theme),
                  _DetailRow('Status', 'Pending Settlement', theme),
                  _DetailRow('Hop Count', '0', theme),
                  _DetailRow('TTL', '10', theme),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Route
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Transaction Route',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _RouteStep(
                    'Created',
                    'Transaction signed & encrypted',
                    true,
                    theme,
                  ),
                  _RouteStep(
                    'Queued',
                    'Waiting for BLE connection',
                    false,
                    theme,
                  ),
                  _RouteStep(
                    'Forwarded',
                    'Sent through mesh relay',
                    false,
                    theme,
                  ),
                  _RouteStep('Received', 'Arrived at gateway', false, theme),
                  _RouteStep('Verified', 'Backend verification', false, theme),
                  _RouteStep(
                    'Settled',
                    'Simulated settlement complete',
                    false,
                    theme,
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

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;
  final ThemeData theme;

  const _DetailRow(this.label, this.value, this.theme);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RouteStep extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool completed;
  final ThemeData theme;

  const _RouteStep(this.title, this.subtitle, this.completed, this.theme);

  @override
  Widget build(BuildContext context) {
    final color = completed
        ? AppTheme.success
        : theme.colorScheme.outlineVariant;
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: completed
                  ? color.withValues(alpha: 0.1)
                  : Colors.transparent,
              shape: BoxShape.circle,
              border: Border.all(color: color, width: 2),
            ),
            child: completed
                ? Icon(Icons.check_rounded, size: 16, color: color)
                : null,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: completed
                        ? theme.colorScheme.onSurface
                        : theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                Text(
                  subtitle,
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: theme.colorScheme.outline,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
