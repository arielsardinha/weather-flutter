import 'package:open_weather_map/app/modules/home/domain/entities/forecast.dart';
import 'package:open_weather_map/app/modules/home/domain/entities/lat_lng.dart';

abstract interface class ForecastUseCaseGetAll {
  Future<Forecast> exec({
    String? search,
    LatLng? latLng,
    required String units,
  });
}
