import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nip/core/security/security_constants.dart';
import 'package:nip/features/security/services/security_service_impl.dart';

void main() {
  group('SecurityServiceImpl Tests', () {
    test('initializeIdentity generates new keys when none exist', () async {
      // To satisfy Dart type checking we need to use a real mock or proper type.
      // flutter_secure_storage has a setMockInitialValues for testing.
      // Let's use that instead!
      FlutterSecureStorage.setMockInitialValues({});
      final secureStorage = const FlutterSecureStorage();
      final service = SecurityServiceImpl(secureStorage);

      expect(service.currentIdentity.isEmpty, true);

      final identity = await service.initializeIdentity();
      expect(identity.isEmpty, false);
      expect(identity.deviceId.startsWith('nip-'), true);
      expect(
        identity.publicKeyBytes.length,
        SecurityConstants.ed25519PublicKeyLength,
      );

      final storedDeviceId = await secureStorage.read(
        key: SecurityConstants.prefDeviceId,
      );
      expect(storedDeviceId, identity.deviceId);
    });

    test('initializeIdentity loads existing keys', () async {
      FlutterSecureStorage.setMockInitialValues({});
      final secureStorage = const FlutterSecureStorage();
      final service1 = SecurityServiceImpl(secureStorage);
      final identity1 = await service1.initializeIdentity();

      final service2 = SecurityServiceImpl(secureStorage);
      final identity2 = await service2.initializeIdentity();

      expect(identity1.deviceId, identity2.deviceId);
      expect(identity1.publicKeyBytes, identity2.publicKeyBytes);
    });

    test('signData produces valid verifiable signatures', () async {
      FlutterSecureStorage.setMockInitialValues({});
      final secureStorage = const FlutterSecureStorage();
      final service = SecurityServiceImpl(secureStorage);
      final identity = await service.initializeIdentity();

      final payload = utf8.encode('test-transaction-data');
      final signature = await service.signData(payload);

      final valid = await service.verifySignature(
        payload,
        signature,
        identity.publicKeyBytes,
      );
      expect(valid, true);

      final badPayload = utf8.encode('tampered-data');
      final valid2 = await service.verifySignature(
        badPayload,
        signature,
        identity.publicKeyBytes,
      );
      expect(valid2, false);
    });
  });
}
