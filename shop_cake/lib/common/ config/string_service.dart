import 'dart:math';

const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';

class StringService {
  static String formatNumber({
    String? number,
    int? fractionDigits,
    String? characterDigits,
  }) {
    String _charDigits = characterDigits ?? '';
    if (number == null || number.isEmpty) return '0';
    int fractions = fractionDigits ?? 3;
    int len = number.length;
    if (len < fractions) {
      return number;
    }
    int cnt = 1;
    String ans = '';
    for (int i = len - 1; i >= 0; i--) {
      if (cnt > fractions) {
        cnt = 1;
        ans = '$_charDigits$ans';
      }
      cnt++;
      ans = number[i] + ans;
    }
    if (ans.isEmpty) return '0';
    return ans;
  }

  static String getRandomString(int length) {
    final Random _rnd = Random();
    return String.fromCharCodes(
      Iterable.generate(
        length,
            (_) => _chars.codeUnitAt(
          _rnd.nextInt(_chars.length),
        ),
      ),
    );
  }
}
