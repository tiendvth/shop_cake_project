
import 'package:shop_cake/common/config/string_service.dart';

class FormatTextToNumber {
  static final FormatTextToNumber _formatTextToNumber = FormatTextToNumber();

  static FormatTextToNumber get instance => _formatTextToNumber;

  String _formatTextToMoney(String text) {
    int len = text.length;
    if (len <= 3) {
      return text;
    }

    int cnt = 0;
    String ans = "";
    for (int i = len - 1; i >= 0; i--) {
      ans = text[i] + ans;
      cnt++;
      if (cnt == 3) {
        if (i != 0) {
          ans = " " + ans;
        }
        cnt = 0;
      }
    }
    return ans;
  }

  String getRealPart(String value) {
    String realPart = '';
    String val = value.replaceAll(' ', '');
    int len = val.length;
    int index = 0;
    while (index < len) {
      if (val[index] == '.') {
        break;
      }
      realPart += val[index];
      index++;
    }
    return realPart;
  }

  String getDecimalPart(String value) {
    String val = value.replaceAll(' ', '');
    int len = val.length;

    String decimalPart = '';
    int index = value.indexOf('.');
    index++;
    while (index < len) {
      decimalPart += val[index];
      index++;
    }
    return decimalPart;
  }

  String changeText(String value) {
    String val = value.replaceAll(' ', '');
    int len = val.length;
    if (len <= 3) {
      return val;
    }

    int index = -1;
    index = value.indexOf('.');
    String decimalPart = getDecimalPart(value);
    String realPart = getRealPart(value);

    String x = _formatTextToMoney(decimalPart) == ""
        ? ''
        : _formatTextToMoney(decimalPart);
    String decimal = '';
    if (x.isNotEmpty && x != '0') {
      decimal = (index > 0 ? '.' : '') + x;
    }
    return _formatTextToMoney(realPart) + decimal;
  }

  String _formatDecimalPart(String value) {
    int index = -1;
    for (int i = value.length - 1; i >= 0; i--) {
      if (value[i] != '0') {
        index = i;
        break;
      }
    }
    if (index == -1) return '';
    return value.replaceRange(index + 1, value.length, '');
  }

  String _formatDecimalNumber(String number) {
    if (!number.contains('.')) return number;
    List<String> list = [];
    String decimalPart = '';
    list = number.split('.');
    decimalPart = _formatDecimalPart(list[1]);
    if (decimalPart.isNotEmpty) {
      return '${list[0]}.$decimalPart';
    }
    return list[0];
  }

  static double formatTextToDouble(String formattedNumber) {
    String num = formattedNumber.replaceAll(' ', '');
    return double.parse(num);
  }

  String compactMoney({
    double? money,
    int? fractionDigits,
    TypeCurrencyEnum? typeCurrencyEnum = TypeCurrencyEnum.dollars,
  }) {
    if (money == null || money.toString().isEmpty) return '0';
    double quotient = -1;
    final String realPart = getRealPart(money.toString());
    final int _factionDigits = fractionDigits ?? 2;
    if (_isMillions(realPart: realPart)) {
      quotient = money / 1000000;
      String currency = typeCurrencyEnum!.name(TypeFormat.millions);
      String quotientString =
          _formatDecimalNumber(quotient.toStringAsFixed(_factionDigits));
      return '$quotientString$currency';
    } else if (_isBillion(realPart: realPart)) {
      quotient = money / 1000000000;
      String currency = typeCurrencyEnum!.name(TypeFormat.billions);
      String quotientString =
          _formatDecimalNumber(quotient.toStringAsFixed(_factionDigits));
      return '$quotientString$currency';
    } else if (_isThousand(realPart: realPart)) {
      quotient = money / 1000;
      String currency = typeCurrencyEnum!.name(TypeFormat.thousand);
      String quotientString =
          _formatDecimalNumber(quotient.toStringAsFixed(_factionDigits));
      return '$quotientString$currency';
    }
    return changeText(money.toString());
  }

  String formatPositiveNumber({
    double? money,
    int? fractionDigits,
  }) {
    if (money == null || money < 0) return '';
    if (money == 0) return '0';
    int frac = fractionDigits ?? 0;
    String moneyString = money.toStringAsFixed(frac);
    if (moneyString.contains('.')) {
      List<String> nums = moneyString.split('.');
      String realPart = _formatTextToMoney(nums[0]);
      String decimalPart = _formatTextToMoney(nums[1]);
      return StringService.formatNumber(
          number: '$realPart.$decimalPart',
          fractionDigits: 3,
          characterDigits: ',');
    }
    return StringService.formatNumber(
        number: moneyString, fractionDigits: 3, characterDigits: ',');
  }

  bool _isMillions({String? realPart}) {
    if (realPart == null) return false;
    return realPart.length >= 7 && realPart.length <= 9;
  }

  bool _isBillion({String? realPart}) {
    if (realPart == null) return false;
    return realPart.length >= 10 && realPart.length <= 12;
  }

  bool _isThousand({String? realPart}) {
    if (realPart == null) return false;
    return realPart.length >= 4 && realPart.length <= 6;
  }
}

enum TypeFormat {
  billions,
  millions,
  thousand,
}

enum TypeCurrencyEnum {
  unCurrency,
  normal,
  compact,
  dollars;

  String name(TypeFormat typeFormat) {
    switch (this) {
      case TypeCurrencyEnum.normal:
        switch (typeFormat) {
          case TypeFormat.billions:
            return Currency.billions;
          case TypeFormat.millions:
            return Currency.millions;
          default:
            return Currency.thousand;
        }
      case TypeCurrencyEnum.compact:
        switch (typeFormat) {
          case TypeFormat.billions:
            return CurrencyCompact.billions;
          case TypeFormat.millions:
            return CurrencyCompact.millions;
          default:
            return CurrencyCompact.thousand;
        }
      case TypeCurrencyEnum.unCurrency:
        return '';
      default:
        switch (typeFormat) {
          case TypeFormat.billions:
            return CurrencyDollars.billions;
          case TypeFormat.millions:
            return CurrencyDollars.millions;
          default:
            return CurrencyDollars.thousand;
        }
    }
  }
}

class Currency {
  static const String millions = 'triệu';
  static const String billions = 'tỷ';
  static const String thousand = 'nghìn';
}

class CurrencyDollars {
  static const String millions = 'M';
  static const String billions = 'B';
  static const String thousand = 'K';
}

class CurrencyCompact {
  static const String millions = 'tr';
  static const String billions = 'T';
  static const String thousand = '';
}
