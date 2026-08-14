import 'package:intl/intl.dart';

/// Currency and number formatting utilities
class Formatters {
  Formatters._();

  static final _currencyFormat = NumberFormat.currency(
    locale: 'en_IN',
    symbol: '₹',
    decimalDigits: 2,
  );

  static final _compactFormat = NumberFormat.compact(locale: 'en_IN');

  static final _dateFormat = DateFormat('dd MMM yyyy');
  static final _timeFormat = DateFormat('hh:mm a');
  static final _dateTimeFormat = DateFormat('dd MMM yyyy, hh:mm a');

  static String currency(double amount) => _currencyFormat.format(amount);
  static String compact(double amount) => _compactFormat.format(amount);
  static String date(DateTime dt) => _dateFormat.format(dt);
  static String time(DateTime dt) => _timeFormat.format(dt);
  static String dateTime(DateTime dt) => _dateTimeFormat.format(dt);

  static String transactionId(String id) {
    if (id.length <= 8) return id.toUpperCase();
    return '${id.substring(0, 4)}...${id.substring(id.length - 4)}'
        .toUpperCase();
  }

  static String deviceId(String id) {
    if (id.length <= 12) return id;
    return '${id.substring(0, 6)}...${id.substring(id.length - 4)}';
  }
}
