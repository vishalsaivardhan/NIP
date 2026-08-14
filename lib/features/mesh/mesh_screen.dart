import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nip/core/config/app_theme.dart';

class MeshScreen extends ConsumerWidget {
  const MeshScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Mesh Network')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Mesh Stats
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _MeshStat(
                      value: '0',
                      label: 'Nodes',
                      color: AppTheme.meshRelay,
                      theme: theme,
                    ),
                    _MeshStat(
                      value: '0',
                      label: 'Relays',
                      color: AppTheme.meshCustomer,
                      theme: theme,
                    ),
                    _MeshStat(
                      value: '0',
                      label: 'Gateways',
                      color: AppTheme.meshGateway,
                      theme: theme,
                    ),
                    _MeshStat(
                      value: '0',
                      label: 'Packets',
                      color: AppTheme.pending,
                      theme: theme,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Network Visualization Area
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: colorScheme.surfaceContainerLowest,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: colorScheme.outlineVariant.withValues(alpha: 0.5),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Placeholder mesh visualization
                    _MeshPlaceholder(theme: theme, colorScheme: colorScheme),
                    const SizedBox(height: 16),
                    Text(
                      'Mesh Visualization',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Connect devices to see the mesh topology\n'
                      'and packet flow visualization',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Legend
            Card(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _LegendItem(
                      'Customer',
                      AppTheme.meshCustomer,
                      Icons.person_rounded,
                      theme,
                    ),
                    _LegendItem(
                      'Merchant',
                      AppTheme.meshMerchant,
                      Icons.store_rounded,
                      theme,
                    ),
                    _LegendItem(
                      'Relay',
                      AppTheme.meshRelay,
                      Icons.hub_rounded,
                      theme,
                    ),
                    _LegendItem(
                      'Gateway',
                      AppTheme.meshGateway,
                      Icons.cell_tower_rounded,
                      theme,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MeshStat extends StatelessWidget {
  final String value;
  final String label;
  final Color color;
  final ThemeData theme;

  const _MeshStat({
    required this.value,
    required this.label,
    required this.color,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
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

class _MeshPlaceholder extends StatelessWidget {
  final ThemeData theme;
  final ColorScheme colorScheme;

  const _MeshPlaceholder({required this.theme, required this.colorScheme});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: CustomPaint(
        size: const Size(300, 200),
        painter: _MeshPlaceholderPainter(colorScheme),
      ),
    );
  }
}

class _MeshPlaceholderPainter extends CustomPainter {
  final ColorScheme colorScheme;

  _MeshPlaceholderPainter(this.colorScheme);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..color = colorScheme.outlineVariant.withValues(alpha: 0.4);

    // Draw placeholder circles representing mesh nodes
    final positions = [
      Offset(center.dx - 80, center.dy - 50),
      Offset(center.dx + 80, center.dy - 50),
      Offset(center.dx, center.dy + 50),
      Offset(center.dx - 60, center.dy + 20),
      Offset(center.dx + 60, center.dy + 20),
    ];

    // Draw connections
    final linePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..color = colorScheme.outlineVariant.withValues(alpha: 0.2);

    for (var i = 0; i < positions.length; i++) {
      for (var j = i + 1; j < positions.length; j++) {
        canvas.drawLine(positions[i], positions[j], linePaint);
      }
    }

    // Draw nodes
    final nodePaint = Paint()
      ..style = PaintingStyle.fill
      ..color = colorScheme.outlineVariant.withValues(alpha: 0.3);

    for (final pos in positions) {
      canvas.drawCircle(pos, 12, nodePaint);
      canvas.drawCircle(pos, 12, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _LegendItem extends StatelessWidget {
  final String label;
  final Color color;
  final IconData icon;
  final ThemeData theme;

  const _LegendItem(this.label, this.color, this.icon, this.theme);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: color),
        const SizedBox(width: 4),
        Text(
          label,
          style: theme.textTheme.labelSmall?.copyWith(
            color: color,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
