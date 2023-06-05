// File config
// @project food
// @author phanmanhha198 on 15-07-2021

import 'package:network/network.dart';

class BuildConfig with ConfigMixin implements Config {
  BuildConfig._({
    this.connectTimeout,
    this.receiveTimeout,
    this.socketUrl,
    required this.baseUrl,
  });

  static BuildConfig? _singleton;

  factory BuildConfig([FlavorConfig? flavorConfig = FlavorConfig.dev]) {
    if (_singleton != null) return _singleton!;
    assert(flavorConfig != null, "flavorConfig required");
    _singleton = flavorConfig?.config;
    return _singleton!;
  }

  BuildConfig._dev() : this._(baseUrl: "http://13.213.7.133");

  BuildConfig._release() : this._(baseUrl: "http://13.213.7.133");

  @override
  int? connectTimeout;

  @override
  int? receiveTimeout;

  @override
  String? socketUrl;

  @override
  String? baseUrl;
}

enum FlavorConfig { dev, release }

extension FlavorConfigExtension on FlavorConfig {
  BuildConfig get config {
    switch (this) {
      case FlavorConfig.dev:
        return BuildConfig._dev();
      case FlavorConfig.release:
        return BuildConfig._release();
    }
  }
}
