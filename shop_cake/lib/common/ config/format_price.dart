import 'package:easy_localization/easy_localization.dart';

class FormatPrice {
  static String format(double price) {
    return NumberFormat.currency(locale: 'vi').format(price);
  }
  static String formatVND(double price) {
    return NumberFormat.currency(locale: 'vi', symbol: 'đ').format(price);
  }
}