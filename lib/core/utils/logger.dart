import 'dart:developer' as developer;

/// Centralized logging utility for NIP / ProxiUPI
class AppLogger {
  AppLogger._();

  static const String _tag = 'NIP';

  static void debug(String message, {String? tag}) {
    developer.log(message, name: tag ?? _tag, level: 500);
  }

  static void info(String message, {String? tag}) {
    developer.log(message, name: tag ?? _tag, level: 800);
  }

  static void warning(String message, {String? tag}) {
    developer.log(message, name: tag ?? _tag, level: 900);
  }

  static void error(
    String message, {
    String? tag,
    Object? error,
    StackTrace? stackTrace,
  }) {
    developer.log(
      message,
      name: tag ?? _tag,
      level: 1000,
      error: error,
      stackTrace: stackTrace,
    );
  }

  static void ble(String message) => debug(message, tag: 'NIP.BLE');
  static void mesh(String message) => debug(message, tag: 'NIP.MESH');
  static void crypto(String message) => debug(message, tag: 'NIP.CRYPTO');
  static void payment(String message) => debug(message, tag: 'NIP.PAYMENT');
  static void gateway(String message) => debug(message, tag: 'NIP.GATEWAY');
  static void sync(String message) => debug(message, tag: 'NIP.SYNC');
  static void security(String message) => debug(message, tag: 'NIP.SECURITY');
}
