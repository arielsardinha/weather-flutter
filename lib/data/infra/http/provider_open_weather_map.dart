// ignore: library_prefixes
import 'package:dio/dio.dart' as _dioPackage;
import 'package:open_weather_map/data/infra/http/http.dart';
import 'package:open_weather_map/data/infra/http/request.dart';
import 'package:open_weather_map/data/infra/http/response.dart';

final class ProviderOpenweathermap implements HttpImpl {
  final _dio = _dioPackage.Dio();

  ProviderOpenweathermap() {
    configureDio();
  }

  void configureDio() {
    _dio.options.baseUrl = 'https://api.openweathermap.org/data/2.5';
    _dio.options.connectTimeout = const Duration(seconds: 5);
    _dio.options.receiveTimeout = const Duration(seconds: 3);

    _dio.interceptors.add(
      _dioPackage.InterceptorsWrapper(
        onRequest: (options, handler) {
          const key = "dae1320fcc7b39a52af3156300ed10b6";
          options.queryParameters.addAll({'appid': key});
          return handler.next(options);
        },
      ),
    );
  }

  @override
  Future<Response<T>> get<T>(Request request) async {
    final response =
        await _dio.get(request.path, queryParameters: request.query);

    return Response<T>(data: response.data);
  }
}
