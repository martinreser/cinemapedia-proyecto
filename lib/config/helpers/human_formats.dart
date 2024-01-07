import 'package:intl/intl.dart';

class HumanFormats {
  static String number(double number) {
    final formattedNumber =
        NumberFormat.compactCurrency(decimalDigits: 0, symbol: '', locale: 'en')
            .format(number);

    return formattedNumber;
  }

  static String reduceDecimals(double number) {
    final formattedNumber = NumberFormat.compact(locale: 'en').format(number);

    return formattedNumber;
  }
}
