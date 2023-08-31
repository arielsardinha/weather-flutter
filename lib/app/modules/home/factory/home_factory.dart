import 'package:open_weather_map/app/modules/home/datalayer/remote_forecast_get_all.dart';
import 'package:open_weather_map/app/modules/home/datalayer/remote_weather_get_all.dart';
import 'package:open_weather_map/app/modules/home/presentation/blocs/forecast/forecast_bloc.dart';
import 'package:open_weather_map/app/modules/home/presentation/blocs/weather/weather_bloc.dart';
import 'package:open_weather_map/data/repository/weather/weather_provider_dio_repository.dart';
import 'package:open_weather_map/app/modules/home/domain/use_cases/forecast/forecast_use_case_get_all.dart';
import 'package:open_weather_map/app/modules/home/domain/use_cases/weather/weather_use_get_all.dart';
import 'package:open_weather_map/data/utils/initial_providers/initial_providers.dart';

sealed class HomeFactory {
  static init() {
    getIt.registerLazySingleton<WeatherGetAll>(() =>
        RemoteWeatherGetAll(repositoryWeather: getIt<RepositoryWeatherImpl>()));

    getIt.registerLazySingleton<ForecastUseCaseGetAll>(() =>
        RemoteForecastGetAll(
            repositoryWeather: getIt<RepositoryWeatherImpl>()));

    getIt.registerSingleton<WeatherBloc>(
        WeatherBloc(weatherGetAll: getIt<WeatherGetAll>()));
    getIt.registerSingleton<ForecastBloc>(
        ForecastBloc(forecastUseCase: getIt<ForecastUseCaseGetAll>()));
  }
}
