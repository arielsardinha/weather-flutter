import 'package:open_weather_map/data/blocs/forecast/forecast_bloc.dart';
import 'package:open_weather_map/data/blocs/weather/weather_bloc.dart';
import 'package:open_weather_map/data/repository/weather/weather_provider_dio_repository.dart';
import 'package:open_weather_map/data/use_cases/forecast/forecast_use_case_get_all.dart';
import 'package:open_weather_map/data/use_cases/weather/weather_use_get_all.dart';
import 'package:open_weather_map/data/utils/initial_providers/initial_providers.dart';

sealed class HomeFactory {
  static init() {
    getIt.registerLazySingleton<WeatherGetAll>(
        () => WeatherGetAll(repositoryWeather: getIt<RepositoryWeather>()));

    getIt.registerLazySingleton<ForecastUseCaseGetAll>(() =>
        ForecastUseCaseGetAll(repositoryWeather: getIt<RepositoryWeather>()));

    getIt.registerSingleton<WeatherBloc>(
        WeatherBloc(weatherGetAll: getIt<WeatherGetAll>()));
    getIt.registerSingleton<ForecastBloc>(
        ForecastBloc(forecastUseCase: getIt<ForecastUseCaseGetAll>()));
  }
}
