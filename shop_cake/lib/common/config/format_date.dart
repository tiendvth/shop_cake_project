import 'package:easy_localization/easy_localization.dart';

class FormatDate {
  static String formatDate(String date) {
    final dateParse = DateTime.parse(date);
    final dateFormated = DateFormat('dd/MM/yyyy').format(dateParse);
    return dateFormated;
  }
  static String dateFormat(String date) {
    List<String> parts = date.split('/');
    if (parts.length == 3) {
      return DateFormat('dd-MM-yyyy').format(DateTime(int.parse(parts[2]), int.parse(parts[1]), int.parse(parts[0])));
    } else {
      return DateFormat('dd-MM-yyyy').format(DateTime.now());
    }
  }
}