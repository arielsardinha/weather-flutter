import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:localization/localization.dart';
import 'package:open_weather_map/data/entities/forecast.dart';
import 'package:open_weather_map/data/entities/weather.dart';
import 'package:open_weather_map/data/infra/http/http.dart';
import 'package:open_weather_map/data/infra/http/request.dart';
import 'package:open_weather_map/data/repository/weather/weather_repository.dart';

final class RepositoryWeather implements WeatherRepositoryImpl {
  final HttpImpl _httpImpl;

  RepositoryWeather({required HttpImpl httpImpl}) : _httpImpl = httpImpl;

  @override
  Future<Weather> getAll({String? search, String? lat, String? long}) async {
    try {
      final query = {'units': 'metric', 'lang': 'weather_lang'.i18n()};
      if (search != null) {
        query.addAll({"q": search});
      }

      if (lat != null && long != null) {
        query.addAll({"lat": lat, 'lon': long});
      }
      final response =
          await _httpImpl.get(Request(path: '/weather', query: query));

      return Weather.fromJson(response.data);
    } on DioException catch (_) {
      throw 'Não foi possível encontrar o clima de uma cidade com este nome.';
    } catch (e, s) {
      log('Erro inesperado', error: e, stackTrace: s);
      throw 'Erro inesperado!!! Consulte o desenvolvedor';
    }
  }

  @override
  Future<Forecast> getForecast({String? lat, String? long}) async {
    // New method
    try {
      final query = {'units': 'metric', 'lang': 'weather_lang'.i18n()};

      if (lat != null && long != null) {
        query.addAll({"lat": lat, 'lon': long});
      }
      final response =
          await _httpImpl.get(Request(path: '/forecast', query: query));

      return Forecast.fromJson(
          response.data); // Convert response to Forecast entity
    } on DioException catch (_) {
      throw 'Não foi possível encontrar a previsão do tempo para esta localização.';
    } catch (e, s) {
      log('Erro inesperado', error: e, stackTrace: s);
      throw 'Erro inesperado!!! Consulte o desenvolvedor';
    }
  }
}
