import 'dart:async';

import 'package:open_weather_map/data/blocs/weather/weather_events.dart';
import 'package:open_weather_map/data/blocs/weather/weather_states.dart';
import 'package:open_weather_map/data/use_cases/weather/weather_use_get_all.dart';

class WeatherBloc {
  final WeatherGetAll _weatherGetAll;

  final _inputStreamController = StreamController<WeatherEvent>();
  final _outputStreamController = StreamController<WeatherState>();

  Sink<WeatherEvent> get input => _inputStreamController;
  Stream<WeatherState> get stream => _outputStreamController.stream;

  WeatherBloc({required WeatherGetAll weatherGetAll})
      : _weatherGetAll = weatherGetAll {
    _outputStreamController.add(WeatherInitialState());
    _inputStreamController.stream.listen(_mapEventToState);
  }

  Future<void> _mapEventToState(WeatherEvent event) async {
    if (event is WeatherLoadEvent) {
      try {
        _outputStreamController.add(WeatherLoadState());
        final message = event.message;
        final latLong = event.latLong;
        final weather =
            await _weatherGetAll.exec(search: message, latLng: latLong);
        _outputStreamController.add(WeatherSuccessState(weather: weather));
      } catch (e) {
        if (event.latLong != null) {
          _outputStreamController.add(WeatherInitialState());
          return;
        }
        _outputStreamController.add(WeatherErroState(message: e.toString()));
      }
    }
  }

  void dispose() {
    _inputStreamController.close();
    _outputStreamController.close();
  }
}
