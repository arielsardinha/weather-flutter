// ignore_for_file: depend_on_referenced_packages

import 'package:intl/intl.dart';
import 'package:collection/collection.dart' show groupBy;

class ForecastModel {
  final List<ListElement> list;

  ForecastModel({
    required this.list,
  });

  List<ListElement> get afternoonForecasts {
    final forecastsByDay = groupBy(list, (ListElement item) {
      var date = DateTime.fromMillisecondsSinceEpoch(item.dt * 1000);
      return DateFormat('yMd').format(date);
    });

    final afternoonForecasts = <ListElement>[];

    for (final forecasts in forecastsByDay.values) {
      final afternoonForecast = forecasts.reduce((a, b) {
        final hourA = DateTime.fromMillisecondsSinceEpoch(a.dt * 1000).hour;
        final hourB = DateTime.fromMillisecondsSinceEpoch(b.dt * 1000).hour;
        final distanceA = (hourA - 12).abs();
        final distanceB = (hourB - 12).abs();
        return distanceA < distanceB ? a : b;
      });
      afternoonForecasts.add(afternoonForecast);
    }

    return afternoonForecasts;
  }

  factory ForecastModel.fromJson(Map<String, dynamic> json) => ForecastModel(
        list: List<ListElement>.from(
            json["list"].map((x) => ListElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "list": List<dynamic>.from(list.map((x) => x.toJson())),
      };
}

class Coord {
  final double lat;
  final double lon;

  Coord({
    required this.lat,
    required this.lon,
  });

  factory Coord.fromJson(Map<String, dynamic> json) => Coord(
        lat: json["lat"]?.toDouble(),
        lon: json["lon"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "lat": lat,
        "lon": lon,
      };
}

class ListElement {
  final int dt;
  final MainClass main;
  final List<WeatherFromForecast> weather;

  ListElement({
    required this.dt,
    required this.main,
    required this.weather,
  });

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
        dt: json["dt"],
        main: MainClass.fromJson(json["main"]),
        weather: List<WeatherFromForecast>.from(
            json["weather"].map((x) => WeatherFromForecast.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "dt": dt,
        "main": main.toJson(),
        "weather": List<dynamic>.from(weather.map((x) => x.toJson())),
      };
}

class MainClass {
  final double tempMin;
  final double tempMax;

  MainClass({
    required this.tempMin,
    required this.tempMax,
  });

  factory MainClass.fromJson(Map<String, dynamic> json) => MainClass(
        tempMin: json["temp_min"]?.toDouble(),
        tempMax: json["temp_max"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "temp_min": tempMin,
        "temp_max": tempMax,
      };
}

class WeatherFromForecast {
  final String icon;

  WeatherFromForecast({
    required this.icon,
  });

  factory WeatherFromForecast.fromJson(Map<String, dynamic> json) =>
      WeatherFromForecast(
        icon: json["icon"],
      );

  Map<String, dynamic> toJson() => {
        "icon": icon,
      };
}
