import 'package:open_weather_map/app/modules/home/datalayer/models/remote_forecast.dart';
import 'package:open_weather_map/app/modules/home/domain/entities/forecast.dart';
import 'package:open_weather_map/app/modules/home/domain/entities/lat_lng.dart';
import 'package:open_weather_map/app/modules/home/domain/use_cases/forecast/forecast_use_case_get_all.dart';
import 'package:open_weather_map/data/repository/weather/weather_repository.dart';

final class RemoteForecastGetAll implements ForecastUseCaseGetAll {
  final WeatherRepository _repositoryWeather;

  RemoteForecastGetAll({required WeatherRepository repositoryWeather})
      : _repositoryWeather = repositoryWeather;

  @override
  Future<ForecastEntity> exec(
      {String? search, LatLng? latLng, required String units}) async {
    final forecastModel = await _repositoryWeather.getForecast(
      lat: latLng?.lat.toString(),
      long: latLng?.lng.toString(),
      units: units,
    );

    final remoteForecast = RemoteForecast.fromModel(forecastModel);

    return remoteForecast.toEntity();
  }
}
