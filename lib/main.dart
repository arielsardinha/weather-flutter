import 'package:flutter/material.dart';
import 'package:open_weather_map/app/router/pages.dart';
import 'package:open_weather_map/app/router/routers.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'weather',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: Routes.HOME,
      routes: AppRoutes.routes,
    );
  }
}
