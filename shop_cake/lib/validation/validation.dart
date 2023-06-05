import 'package:easy_localization/easy_localization.dart';

class Validation {
  static bool validationPhone(String value) {
    Pattern pattern = r'(^#?(0[3|5|7|8|9])[0-9][0-9]{7}#?$)';
    RegExp regex = new RegExp(pattern.toString());
    if (!regex.hasMatch(value)) return false;
    return true;
  }

  static bool validationLengthInput(String value) {
    Pattern pattern = r'(^[a-z A-Z 0-9]{6,20}$)';
    RegExp regex = new RegExp(pattern.toString());
    if (!regex.hasMatch(value)) return false;
    return true;
  }

  static bool validationDate(String value) {
    Pattern pattern = '(0|1)[0-9]/[0-3][0-9]/(19|20)[0-9]{2}';
    RegExp regex = new RegExp(pattern.toString());
    if (!regex.hasMatch(value)) return false;
    return true;
  }

  static bool validationName(String value) {
    Pattern pattern = r'^[^\s]+( [^\s]+)+$';
    RegExp regex = new RegExp(pattern.toString());
    if (!regex.hasMatch(value)) return false;
    return true;
  }

  static bool validationEmail(String value) {
    Pattern pattern = r"^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$";
    RegExp regex = new RegExp(pattern.toString());
    if (!regex.hasMatch(value)) return false;
    return true;
  }

  static bool validationEmailType2(String value) {
    Pattern pattern = r"^([a-z0-9A-Z]+[-|\.]?)+[a-z0-9A-Z]@([a-z0-9A-Z]+(-[a-z0-9A-Z]+)?\.)+[a-zA-Z]{2,}$";
    RegExp regex = new RegExp(pattern.toString());
    if (!regex.hasMatch(value)) return false;
    return true;
  }

  static bool validationFormDate(String value) {
    Pattern pattern = r'^([0-2][0-9]|(3)[0-1])(\-)(((0)[0-9])|((1)[0-2]))(\-)\d{4}$';
    RegExp regex = new RegExp(pattern.toString());
    if (!regex.hasMatch(value)) return false;
    return true;
  }

  static NumberFormat oCcy = NumberFormat("#,##0", "en_US");
}
