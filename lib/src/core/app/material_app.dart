// File app
// @project food
// @author phanmanhha198 on 17-07-2021

import 'package:flutter/material.dart';

abstract class AppConfig implements LocalizationAppConfig, ThemeConfig {
  String get title;

  Widget? get home;

  GlobalKey<NavigatorState> get navigationKey;

  RouteFactory? get onGenerateRoute;
}

/// Hiện flutter web chưa hoàn hiện -> route fail
abstract class WebAppConfig {
  RouteInformationParser<Object>? get routeInformationParser;

  RouterDelegate<Object>? get routerDelegate;
}

abstract class LocalizationAppConfig {
  Locale? locale;

  Iterable<LocalizationsDelegate<dynamic>>? get localizationsDelegates;

  LocaleResolutionCallback? get localeResolutionCallback;

  Iterable<Locale> get supportedLocales;
}

typedef OnChangeTheme = Function(ThemeMode themeMode);

abstract class ThemeConfig {
  ThemeMode? themeMode;

  ThemeData? get theme;

  ThemeData? get darkTheme;

  static OnChangeTheme? onChangeTheme;

  static changeTheme(ThemeMode themeMode){
      onChangeTheme?.call(themeMode);
  }
}

class ScrollBehaviorModified extends ScrollBehavior {
  const ScrollBehaviorModified();
  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    switch (getPlatform(context)) {
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
      case TargetPlatform.android:
        return const BouncingScrollPhysics();
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return const ClampingScrollPhysics();
    }
  }
}
