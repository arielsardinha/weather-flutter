import 'package:flutter/material.dart';

sealed class Themes {
  static var theme = ValueNotifier(ThemeMode.system);

  static void setThemeMode(ThemeMode theme) {
    Themes.theme.value = theme;
  }

  static final themeDataLight = ThemeData(
    colorScheme: const ColorScheme.light(),
  );
  static final themeDataDark = ThemeData(
    colorScheme: const ColorScheme.dark(),
  );
}
