import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_weather_map/app/modules/home/presentation/blocs/forecast/forecast_event.dart';
import 'package:open_weather_map/app/modules/home/presentation/blocs/forecast/forecast_state.dart';
import 'package:open_weather_map/data/use_cases/forecast/forecast_use_case_get_all.dart';

class ForecastBloc extends Bloc<ForecastEvent, ForecastState> {
  final ForecastUseCaseGetAll _forecastUseCase;

  ForecastBloc({required ForecastUseCaseGetAll forecastUseCase})
      : _forecastUseCase = forecastUseCase,
        super(ForecastInitialState()) {
    on<ForecastLoadEvent>((event, emit) async {
      try {
        emit(ForecastLoadState());
        final latLng = event.latLng;
        final units = event.units;
        final forecast =
            await _forecastUseCase.exec(latLng: latLng, units: units);
        emit(ForecastSuccessState(forecast: forecast));
      } catch (e) {
        emit(ForecastErrorState(message: e.toString()));
      }
    });
  }
}
