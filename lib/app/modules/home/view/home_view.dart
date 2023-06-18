import 'package:flutter/material.dart';
import 'package:open_weather_map/app/modules/home/controller/home_controller.dart';

class HomeView extends StatelessWidget {
  final HomeController controller;
  const HomeView({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: controller.getWeather(search: ''),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const CircularProgressIndicator.adaptive();
            }
            final weater = snapshot.data!;
            return Text(weater.name);
          },
        ),
      ),
    );
  }
}
