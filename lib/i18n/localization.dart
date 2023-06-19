import 'package:flutter/material.dart';

sealed class Localization {
  static ValueNotifier<Locale?> locale = ValueNotifier(null);

  static void setLocale(Locale locale) {
    Localization.locale.value = locale;
  }

  static Locale? handleLocaleFromString(String? localeStr) {
    switch (localeStr) {
      case 'BR':
        return const Locale('pt', 'BR');
      case 'US':
        return const Locale('en', 'US');
      default:
        return null;
    }
  }
}
