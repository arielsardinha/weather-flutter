import 'package:open_weather_map/app/modules/home/domain/entities/forecast.dart';
import 'package:open_weather_map/app/modules/home/domain/entities/weather.dart';

abstract interface class WeatherRepositoryImpl {
  Future<Weather> getAll({String? search, String? lat, String? long, required String units});

  Future<Forecast> getForecast({String? lat, String? long,required String units});
}
