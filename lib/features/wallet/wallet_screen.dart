import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nip/core/constants/app_constants.dart';
import 'package:nip/core/config/app_theme.dart';
import 'package:nip/core/utils/formatters.dart';

class WalletScreen extends ConsumerWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Wallet')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Balance Overview
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Text(
                    'SIMULATED WALLET',
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: colorScheme.outline,
                      letterSpacing: 1.5,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    Formatters.currency(AppConstants.defaultTotalBalance),
                    style: theme.textTheme.displaySmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Total Balance',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Offline Section
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Offline Payment Capability',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _WalletDetailRow(
                    icon: Icons.account_balance_wallet_rounded,
                    label: 'Offline Balance',
                    value: Formatters.currency(
                      AppConstants.defaultOfflineBalance,
                    ),
                    color: AppTheme.success,
                    theme: theme,
                  ),
                  const Divider(height: 24),
                  _WalletDetailRow(
                    icon: Icons.block_rounded,
                    label: 'Offline Spending Limit',
                    value: Formatters.currency(
                      AppConstants.defaultOfflineLimit,
                    ),
                    color: AppTheme.warning,
                    theme: theme,
                  ),
                  const Divider(height: 24),
                  _WalletDetailRow(
                    icon: Icons.confirmation_number_rounded,
                    label: 'Available Tokens',
                    value: '10 tokens',
                    color: colorScheme.primary,
                    theme: theme,
                  ),
                  const Divider(height: 24),
                  _WalletDetailRow(
                    icon: Icons.tag_rounded,
                    label: 'Transaction Counter',
                    value: '0',
                    color: colorScheme.secondary,
                    theme: theme,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Tokens
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Offline Tokens',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Pre-authorized tokens for offline payments',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ...List.generate(
                    5,
                    (i) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: colorScheme.surfaceContainerLowest,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: colorScheme.outlineVariant.withValues(
                              alpha: 0.5,
                            ),
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.token_rounded,
                              color: AppTheme.settled,
                              size: 20,
                            ),
                            const SizedBox(width: 12),
                            Text(
                              'TOKEN${(i + 1).toString().padLeft(3, '0')}',
                              style: theme.textTheme.bodyMedium?.copyWith(
                                fontFamily: 'monospace',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              '₹100',
                              style: theme.textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: colorScheme.primary,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Chip(
                              label: const Text('Available'),
                              labelStyle: theme.textTheme.labelSmall?.copyWith(
                                color: AppTheme.success,
                              ),
                              side: BorderSide(
                                color: AppTheme.success.withValues(alpha: 0.3),
                              ),
                              backgroundColor: AppTheme.success.withValues(
                                alpha: 0.1,
                              ),
                              visualDensity: VisualDensity.compact,
                              padding: EdgeInsets.zero,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Disclaimer
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: colorScheme.errorContainer.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              AppConstants.simulatedPaymentDisclaimer,
              style: theme.textTheme.labelSmall?.copyWith(
                color: colorScheme.onErrorContainer,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

class _WalletDetailRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;
  final ThemeData theme;

  const _WalletDetailRow({
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
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: color, size: 22),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            label,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ),
        Text(
          value,
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
