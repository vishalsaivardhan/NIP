import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nip/core/config/app_theme.dart';

class NearbyDevicesScreen extends ConsumerStatefulWidget {
  const NearbyDevicesScreen({super.key});

  @override
  ConsumerState<NearbyDevicesScreen> createState() =>
      _NearbyDevicesScreenState();
}

class _NearbyDevicesScreenState extends ConsumerState<NearbyDevicesScreen> {
  bool _isScanning = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Nearby Devices'),
        actions: [
          IconButton(
            icon: Icon(
              _isScanning ? Icons.stop_rounded : Icons.refresh_rounded,
            ),
            onPressed: () {
              setState(() => _isScanning = !_isScanning);
              // TODO: Start/stop BLE scanning
            },
            tooltip: _isScanning ? 'Stop Scan' : 'Scan',
          ),
        ],
      ),
      body: _isScanning
          ? _buildScanning(theme, colorScheme)
          : _buildEmpty(theme, colorScheme),
    );
  }

  Widget _buildScanning(ThemeData theme, ColorScheme colorScheme) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 80,
            height: 80,
            child: CircularProgressIndicator(
              strokeWidth: 3,
              color: AppTheme.bleConnected,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Scanning for nearby devices...',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Looking for BLE-enabled ProxiUPI devices',
            style: theme.textTheme.bodySmall?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmpty(ThemeData theme, ColorScheme colorScheme) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: AppTheme.bleConnected.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.bluetooth_searching_rounded,
                size: 48,
                color: AppTheme.bleConnected,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'No Devices Found',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Tap the scan button to discover nearby ProxiUPI devices '
              'using Bluetooth Low Energy.',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: () => setState(() => _isScanning = true),
              icon: const Icon(Icons.bluetooth_searching_rounded),
              label: const Text('Start Scanning'),
            ),
            const SizedBox(height: 32),

            // Expected device info
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Device Discovery Info',
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _InfoRow('Device ID', 'Unique identifier', theme),
                    _InfoRow(
                      'Node Type',
                      'Customer / Merchant / Relay / Gateway',
                      theme,
                    ),
                    _InfoRow('Signal', 'RSSI strength in dBm', theme),
                    _InfoRow(
                      'Status',
                      'Connected / Available / Out of range',
                      theme,
                    ),
                    _InfoRow('Gateway', 'Internet access capability', theme),
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

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;
  final ThemeData theme;

  const _InfoRow(this.label, this.value, this.theme);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          SizedBox(
            width: 80,
            child: Text(
              label,
              style: theme.textTheme.labelSmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          Expanded(child: Text(value, style: theme.textTheme.bodySmall)),
        ],
      ),
    );
  }
}
