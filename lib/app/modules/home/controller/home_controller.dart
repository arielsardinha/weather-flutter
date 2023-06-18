import 'package:open_weather_map/data/entities/weather.dart';
import 'package:open_weather_map/data/use_cases/weather/weather_use_get_all.dart';

final class HomeController {
  final WeatherGetAll _weatherGetAll;

  HomeController({required WeatherGetAll weatherGetAll})
      : _weatherGetAll = weatherGetAll;

  Future<Weather> getWeather({required String search}) async {
    return _weatherGetAll.exec(search: search);
  }
}
