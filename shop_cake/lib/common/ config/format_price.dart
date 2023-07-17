import 'package:easy_localization/easy_localization.dart';

class FormatPrice {
  String currencyCode = 'đ';
  static String format(double price) {
    return NumberFormat.currency(locale: 'vi').format(price);
  }
  static String formatVND(double? price) {
    return NumberFormat.currency(locale: 'vi', symbol: 'đ').format(price);
  }
  static String formatStringVND(String price) {
    return NumberFormat.currency(locale: 'vi', symbol: 'đ').format(price);
  }
  static String formatString(double price) {
    return NumberFormat.currency(locale: 'vi').format(price);
  }
  static String formatString2(double price) {
    return NumberFormat.currency(locale: 'vi', symbol: 'đ').format(price);
  }
  static String formatPrice(double price) {
    String formattedAmount = NumberFormat.currency(
      locale: 'vi', // Ngôn ngữ và quốc gia (có thể thay đổi)
      symbol: '', // Ký hiệu tiền tệ, ví dụ: '$' cho đô la Mỹ
    ).format(price);
    String formattedCurrency = NumberFormat.simpleCurrency(
      locale: 'vi',
      name: 'đ', // Mã tiền tệ, ví dụ: 'USD' cho đô la Mỹ
    ).currencySymbol;
    String result = '$formattedAmount $formattedCurrency';
    return result;
  }
  static String formatPriceToInt(int? price) {
    return NumberFormat.currency(locale: 'vi', symbol: 'đ').format(price);
  }
}