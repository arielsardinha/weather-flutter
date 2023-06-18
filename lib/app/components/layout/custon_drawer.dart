import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
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
  void setTheme(ThemeMode theme) {
    Themes.setThemeMode(theme);
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
                title: Text('dark'.i18n()),
                onTap: () {
                  setTheme(ThemeMode.dark);
                },
              ),
              ListTile(
                dense: true,
                title: Text('light'.i18n()),
                onTap: () {
                  setTheme(ThemeMode.light);
                },
              ),
              ListTile(
                dense: true,
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
                title: Text('portugues'.i18n()),
                onTap: () {
                  Localization.setLocale(const Locale('pt', 'BR'));
                },
              ),
              ListTile(
                dense: true,
                title: Text('english'.i18n()),
                onTap: () {
                  Localization.setLocale(const Locale('en', 'US'));
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
                title: Text('Celsius'.i18n()),
                onTap: () {
                  Temperature.setTemperature(TemperatureEnum.metric);
                },
              ),
              ListTile(
                dense: true,
                title: Text('Fahrenheit'.i18n()),
                onTap: () {
                  Temperature.setTemperature(TemperatureEnum.imperial);
                },
              ),
              ListTile(
                dense: true,
                title: Text('Kelvin'.i18n()),
                onTap: () {
                  Temperature.setTemperature(TemperatureEnum.standard);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
