/// Base exception for all NIP app errors
class NipException implements Exception {
  final String message;
  final String? code;
  final dynamic originalError;

  const NipException(this.message, {this.code, this.originalError});

  @override
  String toString() => 'NipException($code): $message';
}

/// Bluetooth-related errors
class BleException extends NipException {
  const BleException(super.message, {super.code, super.originalError});
}

/// Cryptography-related errors
class CryptoException extends NipException {
  const CryptoException(super.message, {super.code, super.originalError});
}

/// Transaction-related errors
class TransactionException extends NipException {
  const TransactionException(super.message, {super.code, super.originalError});
}

/// Wallet-related errors
class WalletException extends NipException {
  const WalletException(super.message, {super.code, super.originalError});
}

/// Mesh networking errors
class MeshException extends NipException {
  const MeshException(super.message, {super.code, super.originalError});
}

/// Database/persistence errors
class StorageException extends NipException {
  const StorageException(super.message, {super.code, super.originalError});
}

/// Supabase/backend errors
class BackendException extends NipException {
  const BackendException(super.message, {super.code, super.originalError});
}

/// Security-related errors
class SecurityException extends NipException {
  const SecurityException(super.message, {super.code, super.originalError});
}

/// Gateway errors
class GatewayException extends NipException {
  const GatewayException(super.message, {super.code, super.originalError});
}
