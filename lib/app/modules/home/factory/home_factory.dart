import 'package:open_weather_map/data/blocs/forecast/forecast_bloc.dart';
import 'package:open_weather_map/data/blocs/weather/weather_bloc.dart';
import 'package:open_weather_map/data/infra/http/provider_open_weather_map.dart';
import 'package:open_weather_map/data/repository/weather/weather_provider_dio_repository.dart';
import 'package:open_weather_map/data/use_cases/forecast/forecast_use_case_get_all.dart';
import 'package:open_weather_map/data/use_cases/weather/weather_use_get_all.dart';

sealed class HomeFactory {
  static final WeatherBloc weatherBloc = _getWeatherBloc();
  static final ForecastBloc forecastBloc = _getForecastBloc();

  static WeatherBloc _getWeatherBloc() {
    return WeatherBloc(weatherGetAll: _getWeatherGetAll());
  }

  static ForecastBloc _getForecastBloc() {
    return ForecastBloc(forecastUseCase: _getForecastUseCaseGetAll());
  }

  static WeatherGetAll _getWeatherGetAll() {
    return WeatherGetAll(repositoryWeather: _getRepositoryWeather());
  }

  static ForecastUseCaseGetAll _getForecastUseCaseGetAll() {
    return ForecastUseCaseGetAll(repositoryWeather: _getRepositoryWeather());
  }

  static RepositoryWeather _getRepositoryWeather() {
    return RepositoryWeather(httpImpl: ProviderOpenweathermap());
  }
}
