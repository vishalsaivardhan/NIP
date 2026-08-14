import 'dart:convert';

import 'package:cryptography/cryptography.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:nip/core/errors/app_exceptions.dart';
import 'package:nip/core/security/security_constants.dart';
import 'package:nip/domain/entities/device_identity.dart';
import 'package:nip/domain/services/security_service.dart';

class SecurityServiceImpl implements SecurityService {
  final FlutterSecureStorage _secureStorage;
  DeviceIdentity _currentIdentity = DeviceIdentity.empty();
  SimpleKeyPair? _keyPair;

  SecurityServiceImpl(this._secureStorage);

  @override
  DeviceIdentity get currentIdentity => _currentIdentity;

  @override
  Future<DeviceIdentity> initializeIdentity() async {
    try {
      final pubKeyBase64 = await _secureStorage.read(
        key: SecurityConstants.prefPublicKey,
      );
      final privKeyBase64 = await _secureStorage.read(
        key: SecurityConstants.prefPrivateKey,
      );
      final storedDeviceId = await _secureStorage.read(
        key: SecurityConstants.prefDeviceId,
      );

      if (pubKeyBase64 != null &&
          privKeyBase64 != null &&
          storedDeviceId != null) {
        // Keys already exist
        final pubBytes = base64Decode(pubKeyBase64);
        final privBytes = base64Decode(privKeyBase64);

        _keyPair = SimpleKeyPairData(
          privBytes,
          publicKey: SimplePublicKey(pubBytes, type: KeyPairType.ed25519),
          type: KeyPairType.ed25519,
        );

        _currentIdentity = DeviceIdentity(
          deviceId: storedDeviceId,
          publicKeyBytes: pubBytes,
        );
        return _currentIdentity;
      }

      // Generate new keys
      final algorithm = Ed25519();
      final newKeyPair = await algorithm.newKeyPair();
      final publicKey = await newKeyPair.extractPublicKey();

      final SimpleKeyPairData keyPairData = await newKeyPair.extract();

      final pubBytes = publicKey.bytes;
      final privBytes = keyPairData.bytes;

      // Ensure length requirements (Ed25519 private key data object contains only the seed usually, but we keep it opaque via cryptography pkg)

      final generatedDeviceId =
          'nip-${base64UrlEncode(pubBytes).substring(0, 16).replaceAll('=', '')}';

      // Save securely
      await _secureStorage.write(
        key: SecurityConstants.prefPublicKey,
        value: base64Encode(pubBytes),
      );
      await _secureStorage.write(
        key: SecurityConstants.prefPrivateKey,
        value: base64Encode(privBytes),
      );
      await _secureStorage.write(
        key: SecurityConstants.prefDeviceId,
        value: generatedDeviceId,
      );

      _keyPair = keyPairData;
      _currentIdentity = DeviceIdentity(
        deviceId: generatedDeviceId,
        publicKeyBytes: pubBytes,
      );

      return _currentIdentity;
    } catch (e) {
      throw SecurityException('Failed to initialize device identity: $e');
    }
  }

  @override
  Future<List<int>> signData(List<int> data) async {
    if (_keyPair == null) {
      throw SecurityException('Identity not initialized. Cannot sign data.');
    }
    final algorithm = Ed25519();
    final signature = await algorithm.sign(data, keyPair: _keyPair!);
    return signature.bytes;
  }

  @override
  Future<bool> verifySignature(
    List<int> data,
    List<int> signature,
    List<int> publicKeyBytes,
  ) async {
    final algorithm = Ed25519();
    final pubKey = SimplePublicKey(publicKeyBytes, type: KeyPairType.ed25519);
    final sigObj = Signature(signature, publicKey: pubKey);
    return algorithm.verify(data, signature: sigObj);
  }
}
