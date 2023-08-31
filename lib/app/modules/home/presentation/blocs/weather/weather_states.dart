import 'package:open_weather_map/app/modules/home/domain/entities/weather.dart';

sealed class WeatherState {
  WeatherState();
}

final class WeatherInitialState extends WeatherState {
  WeatherInitialState();
}

final class WeatherLoadState extends WeatherState {
  WeatherLoadState();
}

final class WeatherSuccessState extends WeatherState {
  final Weather weather;
  WeatherSuccessState({required this.weather});
}

final class WeatherErroState extends WeatherState {
  final String message;
  WeatherErroState({this.message = ''});
}
