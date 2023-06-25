import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:open_weather_map/data/infra/storage/storage.dart';
import 'package:open_weather_map/data/utils/enuns/temperature_enum.dart';
import 'package:open_weather_map/data/utils/temperature/temperature.dart';
import 'package:open_weather_map/themes/theme.dart';
import 'package:open_weather_map/i18n/localization.dart';

class CustonDrawer extends StatefulWidget {
  const CustonDrawer({super.key});

  @override
  State<CustonDrawer> createState() => _CustonDrawerState();
}

class _CustonDrawerState extends State<CustonDrawer> {
  final storage = Storage();
  void setTheme(ThemeMode theme) {
    Themes.setThemeMode(theme);
    setState(() {});
    storage.save(storage: StorageEnum.theme, data: {'name': theme.name});
  }

  void setLanguagem(Locale locale) {
    Localization.setLocale(locale);
    storage.save(
      storage: StorageEnum.language,
      data: {
        'language_code': locale.languageCode,
        'country_code': locale.countryCode
      },
    );
    setState(() {});
  }

  void setTemperature(TemperatureEnum temperature) {
    Temperature.setTemperature(temperature);
    storage.save(
      storage: StorageEnum.temperatureUnit,
      data: {'name': temperature.name},
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final isLightTheme = Theme.of(context).brightness == Brightness.light;

    return Drawer(
      child: ListView(
        children: [
          ExpansionTile(
            title: Text('theme'.i18n()),
            leading: Icon(
              isLightTheme
                  ? Icons.light_mode_outlined
                  : Icons.dark_mode_outlined,
            ),
            children: [
              ListTile(
                dense: true,
                selected: Themes.theme.value == ThemeMode.dark,
                title: Text('dark'.i18n()),
                onTap: () {
                  setTheme(ThemeMode.dark);
                },
              ),
              ListTile(
                dense: true,
                selected: Themes.theme.value == ThemeMode.light,
                title: Text('light'.i18n()),
                onTap: () {
                  setTheme(ThemeMode.light);
                },
              ),
              ListTile(
                dense: true,
                selected: Themes.theme.value == ThemeMode.system,
                title: Text('system'.i18n()),
                onTap: () {
                  setTheme(ThemeMode.system);
                },
              ),
            ],
          ),
          ExpansionTile(
            title: Text('languagem'.i18n()),
            leading: const Icon(Icons.language_outlined),
            children: [
              ListTile(
                dense: true,
                selected: Localization.locale.value == const Locale('pt', 'BR'),
                title: Text('portugues'.i18n()),
                onTap: () {
                  setLanguagem(const Locale('pt', 'BR'));
                },
              ),
              ListTile(
                dense: true,
                selected: Localization.locale.value == const Locale('en', 'US'),
                title: Text('english'.i18n()),
                onTap: () {
                  setLanguagem(const Locale('en', 'US'));
                },
              ),
            ],
          ),
          ExpansionTile(
            title: Text('temperature_unit'.i18n()),
            leading: const Icon(Icons.thermostat_outlined),
            children: [
              ListTile(
                dense: true,
                selected:
                    Temperature.temperature.value == TemperatureEnum.metric,
                title: Text('Celsius'.i18n()),
                onTap: () {
                  setTemperature(TemperatureEnum.metric);
                },
              ),
              ListTile(
                dense: true,
                selected:
                    Temperature.temperature.value == TemperatureEnum.imperial,
                title: Text('Fahrenheit'.i18n()),
                onTap: () {
                  setTemperature(TemperatureEnum.imperial);
                },
              ),
              ListTile(
                dense: true,
                selected:
                    Temperature.temperature.value == TemperatureEnum.standard,
                title: Text('Kelvin'.i18n()),
                onTap: () {
                  setTemperature(TemperatureEnum.standard);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
