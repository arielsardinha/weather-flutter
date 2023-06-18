import 'dart:async';

import 'package:open_weather_map/data/blocs/weather/weather_events.dart';
import 'package:open_weather_map/data/blocs/weather/weather_states.dart';
import 'package:open_weather_map/data/use_cases/weather/weather_use_get_all.dart';

class WeatherBloc {
  final WeatherGetAll _weatherGetAll;

  final _inputStreamController = StreamController<WeatherEvent>();
  final _outputStreamController = StreamController<WeatherState>();

  Sink<WeatherEvent> get inputWeather => _inputStreamController;
  Stream<WeatherState> get stream => _outputStreamController.stream;

  WeatherBloc({required WeatherGetAll weatherGetAll})
      : _weatherGetAll = weatherGetAll {
    _outputStreamController.add(WeatherInitialState());
    _inputStreamController.stream.listen(_mapEventToState);
  }

  Future<void> _mapEventToState(WeatherEvent event) async {
    if (event is WeatherLoadEvent) {
      try {
        final message = event.message;
        final weather = await _weatherGetAll.exec(search: message);
        _outputStreamController.add(WeatherSuccessState(weather: weather));
      } catch (e) {
        _outputStreamController.add(WeatherErroState(message: e.toString()));
      }
    }
  }
}
