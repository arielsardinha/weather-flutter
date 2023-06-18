import 'package:open_weather_map/data/entities/forecast.dart';

abstract class ForecastState {}

class ForecastInitialState extends ForecastState {}

class ForecastLoadState extends ForecastState {}

class ForecastSuccessState extends ForecastState {
  final Forecast forecast;

  ForecastSuccessState({required this.forecast});
}

class ForecastErrorState extends ForecastState {
  final String message;

  ForecastErrorState({this.message = ''});
}
