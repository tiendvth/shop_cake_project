import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:localizations/generated/AppLocale.dart';

mixin LocalizationMixin<T extends StatefulWidget> on State<T> {
  Locale? locale;

  @protected
  LocalizationsDelegate get delegate;

  @protected
  Iterable<LocalizationsDelegate<dynamic>>? get localizationsDelegates => [
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ];

  @protected
  LocaleResolutionCallback? get localeResolutionCallback => AppLocale(delegate)
      .resolution(fallback: Locale.fromSubtags(languageCode: "vi"));

  @protected
  Iterable<Locale> get supportedLocales;

  @mustCallSuper
  @override
  void initState() {
    locale = delegate
        .getLocaleCurrent(context, Locale.fromSubtags(languageCode: "vi"));
    AppLocale.onChangedLocale = (locale) {
      setState(() {
        this.locale = locale;
      });
    };
    super.initState();
  }

  @mustCallSuper
  @override
  void dispose() {
    AppLocale.onChangedLocale = null;
    super.dispose();
  }
}