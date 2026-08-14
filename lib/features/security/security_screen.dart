import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nip/core/config/app_theme.dart';
import 'package:nip/core/constants/app_constants.dart';

class SecurityScreen extends ConsumerWidget {
  const SecurityScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Security Dashboard')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Security Score
          Card(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: LinearGradient(
                  colors: [
                    AppTheme.success.withValues(alpha: 0.1),
                    AppTheme.success.withValues(alpha: 0.05),
                  ],
                ),
              ),
              child: Column(
                children: [
                  Container(
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                      color: AppTheme.success.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                      border: Border.all(color: AppTheme.success, width: 3),
                    ),
                    child: const Icon(
                      Icons.shield_rounded,
                      size: 36,
                      color: AppTheme.success,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Security Active',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppTheme.success,
                    ),
                  ),
                  Text(
                    'All security layers operational',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Security Details
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Security Configuration',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _SecurityRow(
                    icon: Icons.enhanced_encryption_rounded,
                    label: 'Encryption',
                    value: AppConstants.encryptionAlgorithm,
                    status: true,
                    theme: theme,
                  ),
                  const Divider(height: 24),
                  _SecurityRow(
                    icon: Icons.verified_rounded,
                    label: 'Digital Signature',
                    value: AppConstants.signatureAlgorithm,
                    status: true,
                    theme: theme,
                  ),
                  const Divider(height: 24),
                  _SecurityRow(
                    icon: Icons.fingerprint_rounded,
                    label: 'Device Identity',
                    value: 'Not Generated',
                    status: false,
                    theme: theme,
                  ),
                  const Divider(height: 24),
                  _SecurityRow(
                    icon: Icons.key_rounded,
                    label: 'Secure Key Storage',
                    value: 'Checking...',
                    status: false,
                    theme: theme,
                  ),
                  const Divider(height: 24),
                  _SecurityRow(
                    icon: Icons.money_off_rounded,
                    label: 'Offline Limit',
                    value: '₹${AppConstants.defaultOfflineLimit.toInt()}',
                    status: true,
                    theme: theme,
                  ),
                  const Divider(height: 24),
                  _SecurityRow(
                    icon: Icons.tag_rounded,
                    label: 'Transaction Counter',
                    value: '0',
                    status: true,
                    theme: theme,
                  ),
                  const Divider(height: 24),
                  _SecurityRow(
                    icon: Icons.hub_rounded,
                    label: 'Network',
                    value: 'BLE Mesh',
                    status: true,
                    theme: theme,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Threat Detection
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Threat Detection',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'No threats detected. Risk scoring module will be '
                    'activated in a later phase.',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _RiskChip('Replay', 'LOW', AppTheme.success, theme),
                      _RiskChip('Double-Spend', 'LOW', AppTheme.success, theme),
                      _RiskChip('Tampering', 'LOW', AppTheme.success, theme),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Note
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: colorScheme.tertiaryContainer.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              'This security dashboard is for prototype demonstration. '
              'It does not claim production-grade security or regulatory approval.',
              style: theme.textTheme.labelSmall?.copyWith(
                color: colorScheme.onTertiaryContainer,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

class _SecurityRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final bool status;
  final ThemeData theme;

  const _SecurityRow({
    required this.icon,
    required this.label,
    required this.value,
    required this.status,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    final color = status ? AppTheme.success : AppTheme.warning;
    return Row(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: color, size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                value,
                style: theme.textTheme.labelSmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
        Icon(
          status ? Icons.check_circle_rounded : Icons.warning_rounded,
          color: color,
          size: 22,
        ),
      ],
    );
  }
}

class _RiskChip extends StatelessWidget {
  final String label;
  final String level;
  final Color color;
  final ThemeData theme;

  const _RiskChip(this.label, this.level, this.color, this.theme);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: color.withValues(alpha: 0.3)),
          ),
          child: Text(
            level,
            style: theme.textTheme.labelSmall?.copyWith(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: theme.textTheme.labelSmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}
