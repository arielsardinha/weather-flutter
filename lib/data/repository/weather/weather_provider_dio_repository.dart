import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:localization/localization.dart';
import 'package:open_weather_map/data/infra/http/http.dart';
import 'package:open_weather_map/data/infra/http/request.dart';
import 'package:open_weather_map/data/repository/weather/models/forecast.dart';
import 'package:open_weather_map/data/repository/weather/models/weather.dart';
import 'package:open_weather_map/data/repository/weather/weather_repository.dart';

final class RepositoryWeatherImpl implements WeatherRepository {
  final HttpImpl _httpImpl;

  RepositoryWeatherImpl({required HttpImpl httpImpl}) : _httpImpl = httpImpl;

  @override
  Future<WeatherModel> getAll({
    String? search,
    String? lat,
    String? long,
    required String units,
  }) async {
    try {
      final query = {'units': units, 'lang': 'weather_lang'.i18n()};
      if (search != null) {
        query.addAll({"q": search});
      }

      if (lat != null && long != null) {
        query.addAll({"lat": lat, 'lon': long});
      }
      final response =
          await _httpImpl.get(Request(path: '/weather', query: query));

      final weather = WeatherModel.fromJson(response.data);

      return weather;
    } on DioException catch (_) {
      throw 'Não foi possível encontrar o clima de uma cidade com este nome.';
    } catch (e, s) {
      log('Erro inesperado', error: e, stackTrace: s);
      throw 'Erro inesperado!!! Consulte o desenvolvedor';
    }
  }

  @override
  Future<ForecastModel> getForecast({
    String? lat,
    String? long,
    required String units,
  }) async {
    try {
      final query = {'units': units, 'lang': 'weather_lang'.i18n()};

      if (lat != null && long != null) {
        query.addAll({"lat": lat, 'lon': long});
      }
      final response =
          await _httpImpl.get(Request(path: '/forecast', query: query));

      return ForecastModel.fromJson(
          response.data); // Convert response to Forecast entity
    } on DioException catch (_) {
      throw 'Não foi possível encontrar a previsão do tempo para esta localização.';
    } catch (e, s) {
      log('Erro inesperado', error: e, stackTrace: s);
      throw 'Erro inesperado!!! Consulte o desenvolvedor';
    }
  }
}
