import 'package:open_weather_map/data/entities/weather.dart';

sealed class WeatherState {
  final Weather? weather;
  WeatherState({required this.weather});
}

final class WeatherInitialState extends WeatherState {
  WeatherInitialState() : super(weather: null);
}

final class WeatherLoadState extends WeatherState {
  WeatherLoadState() : super(weather: null);
}

final class WeatherSuccessState extends WeatherState {
  WeatherSuccessState({required super.weather});
}

final class WeatherErroState extends WeatherState {
  final String message;
  WeatherErroState({this.message = ''}) : super(weather: null);
}
