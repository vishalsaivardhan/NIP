import 'package:equatable/equatable.dart';

/// Represents the cryptographic identity of the device.
/// The [deviceId] is typically derived from the [publicKeyBytes]
/// (e.g., base64 string or unique hash) for readable communication.
class DeviceIdentity extends Equatable {
  final String deviceId;
  final List<int> publicKeyBytes;

  const DeviceIdentity({required this.deviceId, required this.publicKeyBytes});

  @override
  List<Object?> get props => [deviceId, publicKeyBytes];

  factory DeviceIdentity.empty() =>
      const DeviceIdentity(deviceId: 'pending', publicKeyBytes: []);

  bool get isEmpty => deviceId == 'pending' && publicKeyBytes.isEmpty;
}
