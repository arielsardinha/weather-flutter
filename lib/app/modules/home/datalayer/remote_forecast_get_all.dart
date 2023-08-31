import 'package:open_weather_map/app/modules/home/domain/entities/forecast.dart';
import 'package:open_weather_map/app/modules/home/domain/entities/lat_lng.dart';
import 'package:open_weather_map/app/modules/home/domain/use_cases/forecast/forecast_use_case_get_all.dart';
import 'package:open_weather_map/data/repository/weather/weather_repository.dart';

final class RemoteForecastGetAll implements ForecastUseCaseGetAll {
  final WeatherRepository _repositoryWeather;

  RemoteForecastGetAll({required WeatherRepository repositoryWeather})
      : _repositoryWeather = repositoryWeather;

  @override
  Future<Forecast> exec(
      {String? search, LatLng? latLng, required String units}) {
    return _repositoryWeather.getForecast(
      lat: latLng?.lat.toString(),
      long: latLng?.lng.toString(),
      units: units,
    );
  }
}
