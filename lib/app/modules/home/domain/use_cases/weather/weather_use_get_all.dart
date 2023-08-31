import 'package:open_weather_map/app/modules/home/domain/entities/lat_lng.dart';
import 'package:open_weather_map/app/modules/home/domain/entities/weather.dart';

abstract interface class WeatherGetAll {
  Future<Weather> exec({
    String? search,
    LatLng? latLng,
    required String units,
  });
}
