import 'package:common/common.dart';

class AuthServiceImpl extends AuthService {
  static final AuthServiceImpl _singleton = AuthServiceImpl._();
  static const String keyAccessToken = "accessToken";
  static const String keyRefreshToken = "refreshToken";
  String? _accessToken;
  String? _refreshToken;

  AuthServiceImpl._();

  factory AuthServiceImpl([SharedPreferences? shared]) {
    _singleton.sharedPreferences ??= shared;
    return _singleton;
  }

  @override
  Future<bool> isLogin() async {
    return getAccessToken() != null;
  }

  @override
  Future logout() async {
    sharedPreferences?.clear();
  }

  @override
  Future setData(data) async {
    _accessToken = data["accessToken"];
    _refreshToken = data["refreshToken"];
    if (_accessToken != null) sharedPreferences?.setString(keyAccessToken, _accessToken!);
    if (_refreshToken != null) sharedPreferences?.setString(keyRefreshToken, _refreshToken!);
  }

  String? getAccessToken() {
    _accessToken ??= sharedPreferences?.getString(keyAccessToken);
    return _accessToken;
  }

  String? getRefreshToken() {
    _refreshToken ??= sharedPreferences?.getString(keyRefreshToken);
    return _refreshToken;
  }
}
