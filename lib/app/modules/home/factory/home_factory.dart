import 'package:open_weather_map/data/blocs/weather/weather_bloc.dart';
import 'package:open_weather_map/data/infra/http/provider_http.dart';
import 'package:open_weather_map/data/repository/weather_repository.dart';
import 'package:open_weather_map/data/use_cases/weather/weather_use_get_all.dart';

sealed class HomeFactory {
  static final WeatherBloc bloc = _getController();

  static WeatherBloc _getController() {
    return WeatherBloc(weatherGetAll: _getWeatherGetAll());
  }

  static WeatherGetAll _getWeatherGetAll() {
    return WeatherGetAll(repositoryWeather: _getRepositoryWeather());
  }

  static RepositoryWeather _getRepositoryWeather() {
    return RepositoryWeather(httpImpl: ProvideroPenweathermap());
  }
}
