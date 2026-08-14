import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nip/core/config/app_theme.dart';

class DemoScreen extends ConsumerStatefulWidget {
  const DemoScreen({super.key});

  @override
  ConsumerState<DemoScreen> createState() => _DemoScreenState();
}

class _DemoScreenState extends ConsumerState<DemoScreen> {
  int _currentStep = 0;

  static const _steps = [
    _DemoStep(
      title: 'Setup Devices',
      description:
          'Configure 4 phones:\n'
          'Phone A → Customer\n'
          'Phone B → Relay\n'
          'Phone C → Relay\n'
          'Phone D → Gateway',
      icon: Icons.devices_rounded,
    ),
    _DemoStep(
      title: 'Disable Internet',
      description:
          'Disable internet on:\n'
          'Phone A, Phone B, Phone C\n\n'
          'Keep internet enabled on:\nPhone D (Gateway)',
      icon: Icons.wifi_off_rounded,
    ),
    _DemoStep(
      title: 'Initiate Payment',
      description:
          'On Phone A (Customer):\n'
          'Send ₹100 simulated payment\n'
          'Transaction is signed & encrypted',
      icon: Icons.payment_rounded,
    ),
    _DemoStep(
      title: 'BLE Mesh Relay',
      description:
          'Transaction travels:\n'
          'A → B → C → D\n\n'
          'Each relay decrements TTL\n'
          'Payload remains encrypted end-to-end',
      icon: Icons.hub_rounded,
    ),
    _DemoStep(
      title: 'Gateway Sync',
      description:
          'Phone D receives the transaction\n'
          'and uploads it to Supabase\n'
          'via internet connection',
      icon: Icons.cloud_upload_rounded,
    ),
    _DemoStep(
      title: 'Backend Verification',
      description:
          'Supabase Edge Function:\n'
          '• Verifies signature\n'
          '• Checks for duplicates\n'
          '• Validates token\n'
          '• Performs simulated settlement',
      icon: Icons.verified_rounded,
    ),
    _DemoStep(
      title: 'Settlement Complete',
      description:
          'Transaction status:\n'
          'PENDING → VERIFYING → VERIFIED → SETTLED\n\n'
          'This is a SIMULATED settlement.',
      icon: Icons.check_circle_rounded,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Demo Mode'),
        actions: [
          TextButton.icon(
            onPressed: () => setState(() => _currentStep = 0),
            icon: const Icon(Icons.replay_rounded, size: 18),
            label: const Text('Reset'),
          ),
        ],
      ),
      body: Column(
        children: [
          // Disclaimer
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            color: colorScheme.tertiaryContainer.withValues(alpha: 0.3),
            child: Text(
              '🧪 DEMO/PROTOTYPE MODE — All payments are simulated',
              style: theme.textTheme.labelMedium?.copyWith(
                color: colorScheme.onTertiaryContainer,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          // Route visualization
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _DeviceChip(
                  'A',
                  'Customer',
                  AppTheme.meshCustomer,
                  _currentStep >= 2,
                  theme,
                ),
                _Arrow(_currentStep >= 3),
                _DeviceChip(
                  'B',
                  'Relay',
                  AppTheme.meshRelay,
                  _currentStep >= 3,
                  theme,
                ),
                _Arrow(_currentStep >= 3),
                _DeviceChip(
                  'C',
                  'Relay',
                  AppTheme.meshRelay,
                  _currentStep >= 3,
                  theme,
                ),
                _Arrow(_currentStep >= 4),
                _DeviceChip(
                  'D',
                  'Gateway',
                  AppTheme.meshGateway,
                  _currentStep >= 4,
                  theme,
                ),
              ],
            ),
          ),

          // Steps
          Expanded(
            child: Stepper(
              currentStep: _currentStep,
              onStepContinue: () {
                if (_currentStep < _steps.length - 1) {
                  setState(() => _currentStep++);
                }
              },
              onStepCancel: () {
                if (_currentStep > 0) {
                  setState(() => _currentStep--);
                }
              },
              controlsBuilder: (context, details) {
                return Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Row(
                    children: [
                      if (_currentStep < _steps.length - 1)
                        FilledButton(
                          onPressed: details.onStepContinue,
                          child: const Text('Next'),
                        )
                      else
                        FilledButton.icon(
                          onPressed: () => setState(() => _currentStep = 0),
                          icon: const Icon(Icons.replay_rounded),
                          label: const Text('Restart Demo'),
                        ),
                      if (_currentStep > 0) ...[
                        const SizedBox(width: 8),
                        TextButton(
                          onPressed: details.onStepCancel,
                          child: const Text('Back'),
                        ),
                      ],
                    ],
                  ),
                );
              },
              steps: _steps.asMap().entries.map((entry) {
                final index = entry.key;
                final step = entry.value;
                return Step(
                  title: Text(step.title),
                  content: Text(
                    step.description,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      height: 1.5,
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                  isActive: index <= _currentStep,
                  state: index < _currentStep
                      ? StepState.complete
                      : index == _currentStep
                      ? StepState.editing
                      : StepState.indexed,
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class _DemoStep {
  final String title;
  final String description;
  final IconData icon;

  const _DemoStep({
    required this.title,
    required this.description,
    required this.icon,
  });
}

class _DeviceChip extends StatelessWidget {
  final String id;
  final String role;
  final Color color;
  final bool active;
  final ThemeData theme;

  const _DeviceChip(this.id, this.role, this.color, this.active, this.theme);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: active ? color.withValues(alpha: 0.2) : Colors.transparent,
            shape: BoxShape.circle,
            border: Border.all(
              color: active ? color : color.withValues(alpha: 0.3),
              width: 2,
            ),
          ),
          child: Center(
            child: Text(
              id,
              style: theme.textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: active ? color : color.withValues(alpha: 0.5),
              ),
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          role,
          style: theme.textTheme.labelSmall?.copyWith(
            color: color.withValues(alpha: active ? 1.0 : 0.5),
            fontSize: 9,
          ),
        ),
      ],
    );
  }
}

class _Arrow extends StatelessWidget {
  final bool active;

  const _Arrow(this.active);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Icon(
        Icons.arrow_forward_rounded,
        size: 16,
        color: active
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.outlineVariant,
      ),
    );
  }
}
