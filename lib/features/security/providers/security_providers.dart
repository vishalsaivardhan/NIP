import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:nip/domain/entities/device_identity.dart';
import 'package:nip/domain/services/security_service.dart';
import 'package:nip/features/security/services/security_service_impl.dart';

/// Provider for FlutterSecureStorage instance
final secureStorageProvider = Provider<FlutterSecureStorage>((ref) {
  return const FlutterSecureStorage();
});

/// Provider for the SecurityService
final securityServiceProvider = Provider<SecurityService>((ref) {
  final storage = ref.watch(secureStorageProvider);
  return SecurityServiceImpl(storage);
});

/// AsyncProvider that manages the DeviceIdentity state
final deviceIdentityProvider = FutureProvider<DeviceIdentity>((ref) async {
  final service = ref.watch(securityServiceProvider);
  return await service.initializeIdentity();
});
