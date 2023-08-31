import 'package:open_weather_map/app/modules/home/domain/entities/forecast.dart';
import 'package:open_weather_map/app/modules/home/domain/entities/lat_lng.dart';
import 'package:open_weather_map/data/repository/weather/weather_repository.dart';

final class ForecastUseCaseGetAll {
  final WeatherRepositoryImpl _repositoryWeather;

  ForecastUseCaseGetAll({required WeatherRepositoryImpl repositoryWeather})
      : _repositoryWeather = repositoryWeather;
  Future<Forecast> exec({
    String? search,
    LatLng? latLng,
    required String units,
  }) async {
    return _repositoryWeather.getForecast(
      lat: latLng?.lat.toString(),
      long: latLng?.lng.toString(),
      units: units,
    );
  }
}
