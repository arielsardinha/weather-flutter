import 'package:open_weather_map/data/infra/http/response.dart';

class HttpErro<T> extends Error {
  final Response? response;

  HttpErro({required this.response});

  String get message => _handleErro();

  String _handleErro() {
    if (response?.data && response!.data) {
      if (response!.data is Map &&
          (response!.data as Map).containsKey('message')) {
        return response!.data['message'];
      }
    }
    return '';
  }
}
