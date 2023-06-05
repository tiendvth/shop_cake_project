part of auth;

abstract class AuthService {
  SharedPreferences? sharedPreferences;

  Future<bool> isLogin();

  Future logout();

  Future setData(dynamic data);
}
