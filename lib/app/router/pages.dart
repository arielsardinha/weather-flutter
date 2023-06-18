import 'package:flutter/material.dart';
import 'package:open_weather_map/app/modules/home/factory/home_factory.dart';
import 'package:open_weather_map/app/modules/home/view/home_view.dart';
import 'package:open_weather_map/app/router/routers.dart';

sealed class AppRoutes {
  static final routes = <String, Widget Function(BuildContext)>{
    Routes.HOME: (context) => HomeView(
          weatherBloc: HomeFactory.weatherBloc,
          forecastBloc: HomeFactory.forecastBloc,
        ),
  };
}
