import 'dart:async';

import 'package:open_weather_map/data/blocs/forecast/forecast_event.dart';
import 'package:open_weather_map/data/blocs/forecast/forecast_state.dart';
import 'package:open_weather_map/data/use_cases/forecast/forecast_use_case_get_all.dart';

class ForecastBloc {
  final ForecastUseCaseGetAll _forecastUseCase;

  final _inputStreamController = StreamController<ForecastEvent>();
  final _outputStreamController = StreamController<ForecastState>();

  Sink<ForecastEvent> get input => _inputStreamController.sink;
  Stream<ForecastState> get output => _outputStreamController.stream;

  ForecastBloc({required ForecastUseCaseGetAll forecastUseCase})
      : _forecastUseCase = forecastUseCase {
    _outputStreamController.add(ForecastInitialState());
    _inputStreamController.stream.listen(_mapEventToState);
  }

  Future<void> _mapEventToState(ForecastEvent event) async {
    if (event is ForecastLoadEvent) {
      try {
        _outputStreamController.add(ForecastLoadState());
        final latLng = event.latLng;
        final forecast = await _forecastUseCase.exec(latLng: latLng);
        _outputStreamController.add(ForecastSuccessState(forecast: forecast));
      } catch (e) {
        _outputStreamController.add(ForecastErrorState(message: e.toString()));
      }
    }
  }

  void dispose() {
    _inputStreamController.close();
    _outputStreamController.close();
  }
}
