import 'package:open_weather_map/data/infra/http/request.dart';
import 'package:open_weather_map/data/infra/http/response.dart';

abstract interface class HttpImpl {
  Future<Response<T>> get<T>(Request request);
}
