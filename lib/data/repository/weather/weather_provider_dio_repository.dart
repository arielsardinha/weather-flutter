import 'package:open_weather_map/data/entities/weather.dart';
import 'package:open_weather_map/data/infra/http/http.dart';
import 'package:open_weather_map/data/infra/http/request.dart';
import 'package:open_weather_map/data/repository/weather/weather_repository.dart';

final class RepositoryWeather implements WeatherRepositoryImpl {
  final HttpImpl _httpImpl;

  RepositoryWeather({required HttpImpl httpImpl}) : _httpImpl = httpImpl;

  @override
  Future<Weather> getAll({required String search}) async {
    try {
      final response = await _httpImpl.get(
          Request(path: '/weather', query: {"q": search, 'units': 'metric'}));

      return Weather.fromJson(response.data);
    } catch (_) {
      throw 'Não foi possível encontrar o clima de uma cidade com este nome.';
    }
  }
}
