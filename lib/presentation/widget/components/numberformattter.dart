import 'package:intl/intl.dart';

class NumberFormatter {
  static NumberFormat formatter = NumberFormat("#,###.##");

  static String numberFormatter(double value) {
    return formatter.format(value);
  }
}
