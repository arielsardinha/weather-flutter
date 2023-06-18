import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:open_weather_map/app/router/pages.dart';
import 'package:open_weather_map/app/router/routers.dart';
import 'package:localization/localization.dart';
import 'package:open_weather_map/themes/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    LocalJsonLocalization.delegate.directories = ['lib/i18n'];

    return AnimatedBuilder(
      animation: Themes.theme,
      builder: (context, snapshot) {
        return MaterialApp(
          title: 'weather',
          debugShowCheckedModeBanner: false,
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            LocalJsonLocalization.delegate,
          ],
          supportedLocales: const [
            Locale('pt', 'BR'),
            Locale('en', 'US'),
          ],
          theme: Themes.themeDataLight,
          darkTheme: Themes.themeDataDark,
          initialRoute: Routes.HOME,
          themeMode: Themes.theme.value,
          routes: AppRoutes.routes,
        );
      },
    );
  }
}
