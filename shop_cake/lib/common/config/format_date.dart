import 'package:easy_localization/easy_localization.dart';

class FormatDate {
  static String formatDate(String date) {
    final dateParse = DateTime.parse(date);
    final dateFormated = DateFormat('dd/MM/yyyy').format(dateParse);
    return dateFormated;
  }
  static String dateFormat(String date) {
    final dateParse = DateTime.parse(date);
    final dateFormated = DateFormat('dd-MM-yyyy').format(dateParse);
    return dateFormated;
  }
}