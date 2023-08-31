import 'package:open_weather_map/app/modules/home/domain/entities/weather.dart';
import 'package:open_weather_map/data/repository/weather/models/weather.dart';

class RemoteWeather extends WeatherEntity {
  RemoteWeather({
    required super.weather,
    required super.main,
    required super.wind,
    required super.sys,
    required super.name,
    required super.visibility,
    required super.coord,
    required super.dateTime,
    required super.visibilityMessage,
  });

  factory RemoteWeather.fromModel(WeatherModel model) {
    return RemoteWeather(
      weather: model.weather
          .map((element) => WeatherElementEntity(
                main: element.main,
                description: element.description,
                icon: element.icon,
              ))
          .toList(),
      main: MainEntity(
        temp: model.main.temp,
        humidity: model.main.humidity,
        tempMin: model.main.tempMin,
        tempMax: model.main.tempMax,
      ),
      wind: WindEntity(
        speed: model.wind.speed,
      ),
      sys: SysEntity(
        country: model.sys.country,
      ),
      coord: CoordEntity(
        lon: model.coord.lon,
        lat: model.coord.lat,
      ),
      name: model.name,
      visibility: model.visibility,
      dateTime: model.dateTime,
      visibilityMessage: model.visibilityMessage,
    );
  }

  WeatherEntity toEntity() {
    return WeatherEntity(
      weather: weather,
      main: main,
      wind: wind,
      sys: sys,
      name: name,
      visibility: visibility,
      coord: coord,
      dateTime: dateTime,
      visibilityMessage: visibilityMessage,
    );
  }
}
