import 'package:flutter/material.dart';
import 'package:open_weather_map/data/utils/enuns/temperature_enum.dart';

sealed class Temperature {
  static final temperature = ValueNotifier(TemperatureEnum.metric);
  static void setTemperature(TemperatureEnum temperature) {
    Temperature.temperature.value = temperature;
  }

  static TemperatureEnum? handleTemperatureStringToEnum(String? temperature) {
    switch (temperature) {
      case 'metric':
        return TemperatureEnum.metric;
      case 'imperial':
        return TemperatureEnum.imperial;
      case 'standard':
      default:
        return null;
    }
  }

  static String symbol() {
    switch (Temperature.temperature.value) {
      case TemperatureEnum.metric:
        return '°C';
      case TemperatureEnum.imperial:
        return '°F';
      case TemperatureEnum.standard:
      default:
        return 'K';
    }
  }
}
