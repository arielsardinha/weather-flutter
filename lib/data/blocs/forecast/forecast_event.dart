import 'package:open_weather_map/data/entities/lat_lng.dart';

abstract class ForecastEvent {}

class ForecastLoadEvent extends ForecastEvent {
  final LatLng? latLng;
  final String units;

  ForecastLoadEvent({this.latLng, required this.units});
}
