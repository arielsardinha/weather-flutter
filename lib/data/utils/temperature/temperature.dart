import 'package:flutter/material.dart';
import 'package:open_weather_map/data/utils/enuns/temperature_enum.dart';

sealed class Temperature {
  static final temperature = ValueNotifier(TemperatureEnum.standard);
  static void setTemperature(TemperatureEnum temperature) {
    Temperature.temperature.value = temperature;
  }
}
