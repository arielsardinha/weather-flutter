import 'package:open_weather_map/app/modules/home/controller/home_controller.dart';
import 'package:open_weather_map/data/infra/http/provider_http.dart';
import 'package:open_weather_map/data/repository/weather_repository.dart';
import 'package:open_weather_map/data/use_cases/weather/weather_use_get_all.dart';

sealed class HomeFactory {
  static HomeController controller = _getController();

  static HomeController _getController() {
    return HomeController(weatherGetAll: _getWeatherGetAll());
  }

  static WeatherGetAll _getWeatherGetAll() {
    return WeatherGetAll(repositoryWeather: _getRepositoryWeather());
  }

  static RepositoryWeather _getRepositoryWeather() {
    return RepositoryWeather(httpImpl: ProvideroPenweathermap());
  }
}
