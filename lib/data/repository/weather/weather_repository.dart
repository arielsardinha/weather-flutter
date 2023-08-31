import 'package:open_weather_map/data/repository/weather/models/forecast.dart';
import 'package:open_weather_map/data/repository/weather/models/weather.dart';

abstract interface class WeatherRepository {
  Future<WeatherModel> getAll(
      {String? search, String? lat, String? long, required String units});

  Future<ForecastModel> getForecast(
      {String? lat, String? long, required String units});
}
