// File material_web_mixin
// @project food
// @author phanmanhha198 on 17-07-2021

import 'package:common/common.dart';
import 'package:flutter/material.dart';

mixin MaterialAppMixin<T extends StatefulWidget> on State<T> implements AppConfig {
  @override
  GlobalKey<NavigatorState> get navigationKey => NavigatorManager.navRoot;

  @override
  Locale? locale;

  @override
  @protected
  Iterable<LocalizationsDelegate<dynamic>>? get localizationsDelegates => null;

  @override
  @protected
  LocaleResolutionCallback? get localeResolutionCallback => null;

  @override
  @protected
  Iterable<Locale> get supportedLocales => const <Locale>[Locale('en', 'US')];

  @override
  ThemeMode? themeMode = ThemeMode.system;

  @override
  ThemeData? get theme => null;

  @override
  ThemeData? get darkTheme => null;

  @override
  RouteFactory? get onGenerateRoute => null;

  @override
  Widget? get home => null;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigationKey,
      onGenerateTitle: (context) => title,
      locale: locale,
      themeMode: themeMode,
      theme: theme,
      darkTheme: darkTheme,
      builder: (context, child) => MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        child: ScrollConfiguration(behavior: const ScrollBehaviorModified(),
            child: child!),
      ),
      localizationsDelegates: localizationsDelegates,
      localeResolutionCallback: localeResolutionCallback,
      supportedLocales: supportedLocales,
      home: home,
      onGenerateRoute: onGenerateRoute,
    );
  }
}
