// Core constants for NIP / ProxiUPI
class AppConstants {
  AppConstants._();

  // App Info
  static const String appName = 'ProxiUPI';
  static const String appFullName =
      'NIP — Secure Offline Proximity Payment Mesh';
  static const String appTagline =
      'Digital payments, even when the internet isn\'t.';
  static const String appVersion = '0.1.0';

  // Simulated Wallet
  static const double defaultTotalBalance = 10000.0;
  static const double defaultOfflineBalance = 1000.0;
  static const double defaultOfflineLimit = 1000.0;
  static const String currency = '₹';
  static const String currencyCode = 'INR';

  // BLE
  static const int bleDefaultTtl = 10;
  static const Duration bleScanTimeout = Duration(seconds: 15);
  static const Duration bleConnectionTimeout = Duration(seconds: 10);

  // Mesh
  static const int meshMaxHops = 10;
  static const int meshMaxQueueSize = 100;
  static const Duration meshPacketExpiry = Duration(hours: 24);

  // Transaction
  static const Duration transactionExpiry = Duration(hours: 24);
  static const int maxDuplicateCacheSize = 1000;

  // Security
  static const String encryptionAlgorithm = 'AES-256-GCM';
  static const String signatureAlgorithm = 'Ed25519';

  // Disclaimer
  static const String simulatedPaymentDisclaimer =
      'This is a SIMULATED PAYMENT for demonstration purposes only. '
      'No real money is transferred. This prototype does not connect to '
      'real bank accounts or UPI infrastructure.';
}
