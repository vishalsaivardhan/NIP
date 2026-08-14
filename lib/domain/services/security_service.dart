import 'package:nip/domain/entities/device_identity.dart';

/// Interface for generating identities and cryptographic signatures.
abstract class SecurityService {
  /// Initializes the device identity.
  /// Loads from secure storage if exists, or generates a new Ed25519 key pair.
  Future<DeviceIdentity> initializeIdentity();

  /// Gets the current loaded identity.
  DeviceIdentity get currentIdentity;

  /// Signs the provided [data] with the device's private key.
  /// Returns the signature completely detached from the data.
  Future<List<int>> signData(List<int> data);

  /// Verifies a detached [signature] over [data] for a given Ed25519 [publicKeyBytes].
  Future<bool> verifySignature(
    List<int> data,
    List<int> signature,
    List<int> publicKeyBytes,
  );
}
