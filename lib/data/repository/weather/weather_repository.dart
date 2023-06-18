import 'package:open_weather_map/data/entities/weather.dart';

abstract interface class WeatherRepositoryImpl {
  Future<Weather> getAll({String? search, String? lat, String? long});
}
