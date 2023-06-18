import 'package:flutter/material.dart';

sealed class Localization {
  static ValueNotifier<Locale?> locale = ValueNotifier(null);

  static void setLocale(Locale locale) {
    Localization.locale.value = locale;
  }
}
