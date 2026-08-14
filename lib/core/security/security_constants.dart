class SecurityConstants {
  SecurityConstants._();

  /// Keys for flutter_secure_storage
  static const String prefPrivateKey = 'proxiupi_private_key';
  static const String prefPublicKey = 'proxiupi_public_key';
  static const String prefDeviceId = 'proxiupi_device_id';

  /// Standard length in bytes for Ed25519 public key
  static const int ed25519PublicKeyLength = 32;

  /// Standard length in bytes for Ed25519 private key
  static const int ed25519PrivateKeyLength = 32;
}
