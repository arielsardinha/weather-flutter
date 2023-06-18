import 'package:flutter/material.dart';

sealed class CustomTheme {
  static final themeDataLight = ThemeData(
    colorScheme: const ColorScheme.light(),
  );
  static final themeDataDark = ThemeData(
    colorScheme: const ColorScheme.dark(),
  );
}
