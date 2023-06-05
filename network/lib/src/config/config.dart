// File config
// @project food
// @author phanmanhha198 on 13-07-2021
part of network;

abstract class Config {
  String? baseUrl;
  String? socketUrl;
  int? connectTimeout;
  int? receiveTimeout;

  BaseOptions? toOptions();
}

mixin ConfigMixin implements Config {
  @override
  BaseOptions? toOptions() {
    final baseOption = BaseOptions()
      ..connectTimeout = connectTimeout ?? 5000
      ..receiveTimeout = receiveTimeout ?? 5000;
    if (baseUrl != null) baseOption.baseUrl = baseUrl!;
    return baseOption;
  }
}
