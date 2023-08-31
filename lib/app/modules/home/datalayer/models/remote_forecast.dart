import 'package:open_weather_map/app/modules/home/domain/entities/forecast.dart';
import 'package:open_weather_map/data/repository/weather/models/forecast.dart';

class RemoteForecast extends ForecastEntity {
  RemoteForecast({
    required super.afternoonForecasts,
  });

  factory RemoteForecast.fromModel(ForecastModel model) {
    return RemoteForecast(
      afternoonForecasts: model.afternoonForecasts
          .map(
            (element) => ListElementEntity(
              dt: element.dt,
              main: MainClassEntity(
                tempMin: element.main.tempMin,
                tempMax: element.main.tempMax,
              ),
              weather: element.weather
                  .map(
                    (element) => WeatherFromForecastEntity(icon: element.icon),
                  )
                  .toList(),
            ),
          )
          .toList(),
    );
  }

  ForecastEntity toEntity() {
    return ForecastEntity(
      afternoonForecasts: afternoonForecasts,
    );
  }
}
