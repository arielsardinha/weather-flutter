import 'package:open_weather_map/data/entities/weather.dart';
import 'package:open_weather_map/data/repository/weather/weather_repository.dart';

final class WeatherGetAll {
  final WeatherRepositoryImpl _repositoryWeather;

  WeatherGetAll({required WeatherRepositoryImpl repositoryWeather})
      : _repositoryWeather = repositoryWeather;
  Future<Weather> exec({required String search}) async {
    return _repositoryWeather.getAll(search: search);
  }
}
