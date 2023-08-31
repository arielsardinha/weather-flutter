import 'package:open_weather_map/app/modules/home/domain/entities/lat_lng.dart';
import 'package:open_weather_map/app/modules/home/domain/entities/weather.dart';
import 'package:open_weather_map/app/modules/home/domain/use_cases/weather/weather_use_get_all.dart';
import 'package:open_weather_map/data/repository/weather/weather_repository.dart';

final class RemoteWeatherGetAll implements WeatherGetAll {
  final WeatherRepository _repositoryWeather;

  RemoteWeatherGetAll({required WeatherRepository repositoryWeather})
      : _repositoryWeather = repositoryWeather;

  @override
  Future<Weather> exec(
      {String? search, LatLng? latLng, required String units}) {
    return _repositoryWeather.getAll(
      search: search,
      lat: latLng?.lat.toString(),
      long: latLng?.lng.toString(),
      units: units,
    );
  }
}
