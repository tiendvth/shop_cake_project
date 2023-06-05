// File material_stub_mixin
// @project food
// @author phanmanhha198 on 17-07-2021

import 'package:common/common.dart';
import 'package:flutter/material.dart';

mixin MaterialAppMixin<T extends StatefulWidget> on State<T> implements AppConfig {

  @override
  @protected
  Iterable<LocalizationsDelegate<dynamic>>? get localizationsDelegates => null;

  @override
  @protected
  LocaleResolutionCallback? get localeResolutionCallback => null;

  @override
  @protected
  Iterable<Locale> get supportedLocales => [];

  @override
  GlobalKey<NavigatorState> get navigationKey => throw UnimplementedError();

  @override
  Locale? locale;

  @override
  Widget build(BuildContext context) {
    throw UnimplementedError();
  }

  @override
  ThemeMode? themeMode;

  @override
  ThemeData? get theme => null;

  @override
  ThemeData? get darkTheme => null;

  @override
  RouteFactory? get onGenerateRoute => null;

  @override
  Widget? get home => null;
}
