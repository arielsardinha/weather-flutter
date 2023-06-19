import 'package:flutter/material.dart';

sealed class Themes {
  static final theme = ValueNotifier(ThemeMode.system);

  static void setThemeMode(ThemeMode theme) {
    Themes.theme.value = theme;
  }

  static ThemeMode? handleThemeFromStringToTheme(String? theme) {
    switch (theme) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      case 'system':
      default:
        return null;
    }
  }

  static final themeDataLight = ThemeData(
    colorScheme: const ColorScheme.light(),
  );
  static final themeDataDark = ThemeData(
    colorScheme: const ColorScheme.dark(),
  );
}
