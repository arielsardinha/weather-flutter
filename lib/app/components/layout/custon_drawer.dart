import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:open_weather_map/themes/theme.dart';

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
                title: const Text('dark'),
                onTap: () {
                  setTheme(ThemeMode.dark);
                },
              ),
              ListTile(
                dense: true,
                title: const Text('light'),
                onTap: () {
                  setTheme(ThemeMode.light);
                },
              ),
              ListTile(
                dense: true,
                title: const Text('system'),
                onTap: () {
                  Themes.setThemeMode(ThemeMode.system);
                  setTheme(ThemeMode.system);
                },
              ),
            ],
          ),
          ExpansionTile(
            title: const Text('languagem'),
            leading: const Icon(Icons.language_outlined),
            children: [
              ListTile(
                dense: true,
                title: const Text('portugues'),
                onTap: () {},
              ),
              ListTile(
                dense: true,
                title: const Text('english'),
                onTap: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
