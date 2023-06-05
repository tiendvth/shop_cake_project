// File AppLocale
// * @project back_office
// @author phanmanhha198 on 05-12-2019
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

const KEY_LANGUAGE = "language";
var language;

typedef void LocaleChangeCallBack(Locale locale);

extension AppLocale<T> on LocalizationsDelegate<T> {
  static SharedPreferences? _shared;
  static LocaleChangeCallBack? onChangedLocale;

  setShared(SharedPreferences? shared) {
    _shared = shared;
  }

  loadAndSave(Locale locale) {
    this.load(locale);
    language = locale.languageCode;
    _shared?.setString(KEY_LANGUAGE, locale.languageCode);
    onChangedLocale?.call(locale);
  }

  Locale? getLocaleCurrent(BuildContext context, [Locale? defaultLocale]) {
    if (language != null) return Locale(language, "");
    language = _shared?.getString(KEY_LANGUAGE);
    if (language != null)
      return Locale(language, "");
    else
      return defaultLocale ?? Localizations.maybeLocaleOf(context);
  }

  LocaleListResolutionCallback listResolution(
      {Locale? fallback}) {
    return (List<Locale>? locales, Iterable<Locale> supported) {
      if (locales == null || locales.isEmpty) {
        return fallback ?? supported.first;
      } else {
        return _resolve(locales.first, fallback, supported);
      }
    };
  }

  LocaleResolutionCallback resolution(
      {Locale? fallback}) {
    return (Locale? locale, Iterable<Locale> supported) {
      return _resolve(locale, fallback, supported);
    };
  }

  ///
  /// Internal method to resolve a locale from a list of locales.
  ///
  Locale _resolve(Locale? locale, Locale? fallback, Iterable<Locale> supported) {
    if (locale == null || !isSupported(locale)) {
      return fallback ?? supported.first;
    }

    final fallbackLocale = supported.firstWhere((element) {
      if (element.languageCode == locale.languageCode) {
        return true;
      }
      return false;
    }, orElse: () => fallback ?? supported.first);

    return fallbackLocale;
  }
}
