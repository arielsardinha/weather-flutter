import 'package:open_weather_map/data/entities/lat_lng.dart';

sealed class WeatherEvent {}

final class WeatherLoadEvent extends WeatherEvent {
  final LatLng? latLong;
  final String? message;

  WeatherLoadEvent({this.message, this.latLong});
}
