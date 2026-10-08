import 'package:intl/intl.dart';

class CurrencyFormatter {
  static final NumberFormat _formatter = NumberFormat.currency(
    symbol: '\$',
    decimalDigits: 0,
  );

  static final NumberFormat _decimalFormatter = NumberFormat.currency(
    symbol: '\$',
    decimalDigits: 2,
  );

  static String format(num amount) {
    if (amount % 1 == 0) {
      return _formatter.format(amount);
    }
    return _decimalFormatter.format(amount);
  }

  static String formatWithoutSymbol(num amount) {
    return NumberFormat('#,##0').format(amount);
  }
}
