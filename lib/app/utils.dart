import 'package:intl/intl.dart';

extension DoubleExtension on double {
  String formatDecimal(int maxFractionDigits) {
    final formatter = NumberFormat()
      ..minimumFractionDigits = 0
      ..maximumFractionDigits = 2;

    return formatter.format(this);
  }
}
