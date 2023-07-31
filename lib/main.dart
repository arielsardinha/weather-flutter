import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:open_weather_map/app/router/pages.dart';
import 'package:localization/localization.dart';
import 'package:open_weather_map/data/utils/initial_providers/initial_providers.dart';
import 'package:open_weather_map/themes/theme.dart';
import 'package:open_weather_map/i18n/localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  InitialProvider.init();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
      animation: Listenable.merge([Themes.theme, Localization.locale]),
      builder: (context, snapshot) {
        return MaterialApp.router(
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
          locale: Localization.locale.value,
          theme: Themes.themeDataLight,
          darkTheme: Themes.themeDataDark,
          themeMode: Themes.theme.value,
          routerConfig: AppRoutes.routesConfig,
        );
      },
    );
  }
}
