import 'package:open_weather_map/app/modules/home/domain/entities/lat_lng.dart';
import 'package:open_weather_map/app/modules/home/domain/entities/weather.dart';
import 'package:open_weather_map/data/repository/weather/weather_repository.dart';

final class WeatherGetAll {
  final WeatherRepositoryImpl _repositoryWeather;

  WeatherGetAll({required WeatherRepositoryImpl repositoryWeather})
      : _repositoryWeather = repositoryWeather;
  Future<Weather> exec({
    String? search,
    LatLng? latLng,
    required String units,
  }) async {
    return _repositoryWeather.getAll(
      search: search,
      lat: latLng?.lat.toString(),
      long: latLng?.lng.toString(),
      units: units,
    );
  }
}
