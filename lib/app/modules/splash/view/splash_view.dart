import 'package:flutter/material.dart';
import 'package:open_weather_map/app/router/navigator_config.dart';
import 'package:open_weather_map/app/router/routers.dart';
import 'package:open_weather_map/data/infra/storage/storage.dart';
import 'package:open_weather_map/data/utils/temperature/temperature.dart';
import 'package:open_weather_map/i18n/localization.dart';
import 'package:open_weather_map/themes/theme.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    (() async {
      final storage = Storage();
      // final storageTheme = await storage.get(StorageEnum.theme);
      // final storageLocale = await storage.get(StorageEnum.language);
      // final storageTemperature = await storage.get(StorageEnum.temperatureUnit);

      final storages = await Future.wait([
        storage.get(StorageEnum.theme),
        storage.get(StorageEnum.language),
        storage.get(StorageEnum.temperatureUnit)
      ]);

      final storageTheme = storages[0];
      final storageLocale = storages[1];
      final storageTemperature = storages[2];

      final theme = Themes.handleThemeFromStringToTheme(storageTheme?['name']);
      if (theme != null) {
        Themes.setThemeMode(theme);
      }
      final locale =
          Localization.handleLocaleFromString(storageLocale?['country_code']);
      if (locale != null) {
        Localization.setLocale(locale);
      }
      final temperature = Temperature.handleTemperatureStringToEnum(
          storageTemperature?['name']);

      if (temperature != null) {
        Temperature.setTemperature(temperature);
      }
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        CustonNavigator.pushNamed(
          context,
          Routes.HOME,
        );
      });
    })();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/clima_back.jpg',
            fit: BoxFit.cover,
            height: double.maxFinite,
            width: double.maxFinite,
          ),
          const Center(
            child: CircularProgressIndicator.adaptive(),
          )
        ],
      ),
    );
  }
}
