import 'package:dio/dio.dart';
import 'package:open_weather_map/data/entities/weather.dart';
import 'package:open_weather_map/data/infra/http/http.dart';
import 'package:open_weather_map/data/infra/http/request.dart';

final class RepositoryWeather {
  final HttpImpl _httpImpl;

  RepositoryWeather({required HttpImpl httpImpl}) : _httpImpl = httpImpl;

  Future<Weather> getAll({required String search}) async {
    try {
      final response = await _httpImpl
          .get(Request(path: '/weather?q=$search&units=metric&lang=pt_br'));

      return Weather.fromJson(response.data);
    } on DioException catch (e) {
      throw 'Erro ao buscar dados ${e.message}';
    }
  }
}
