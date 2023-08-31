import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_weather_map/app/modules/home/presentation/blocs/weather/weather_events.dart';
import 'package:open_weather_map/app/modules/home/presentation/blocs/weather/weather_states.dart';
import 'package:open_weather_map/data/use_cases/weather/weather_use_get_all.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherGetAll _weatherGetAll;

  WeatherBloc({required WeatherGetAll weatherGetAll})
      : _weatherGetAll = weatherGetAll,
        super(WeatherInitialState()) {
    on<WeatherLoadEvent>((event, emit) async {
      try {
        emit(WeatherLoadState());
        final message = event.message;
        final latLong = event.latLong;
        final units = event.units;
        final weather = await _weatherGetAll.exec(
          search: message,
          latLng: latLong,
          units: units,
        );
        emit(WeatherSuccessState(weather: weather));
      } catch (e) {
        if (event.latLong != null) {
          emit(WeatherInitialState());
          return;
        }
        emit(WeatherErroState(message: e.toString()));
      }
    });
  }

  // Future<void> _mapEventToState(WeatherEvent event) async {
  //   if (event is WeatherLoadEvent) {
  //     try {
  //       _outputStreamController.add(WeatherLoadState());
  //       final message = event.message;
  //       final latLong = event.latLong;
  //       final units = event.units;
  //       final weather = await _weatherGetAll.exec(
  //         search: message,
  //         latLng: latLong,
  //         units: units,
  //       );
  //       _outputStreamController.add(WeatherSuccessState(weather: weather));
  //     } catch (e) {
  //       if (event.latLong != null) {
  //         _outputStreamController.add(WeatherInitialState());
  //         return;
  //       }
  //       _outputStreamController.add(WeatherErroState(message: e.toString()));
  //     }
  //   }
  // }

  // void dispose() {
  //   _inputStreamController.close();
  //   _outputStreamController.close();
  // }
}
