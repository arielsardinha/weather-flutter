class ForecastEntity {
  final List<ListElementEntity> afternoonForecasts;

  ForecastEntity({
    required this.afternoonForecasts,
  });
}

class ListElementEntity {
  final int dt;
  final MainClassEntity main;
  final List<WeatherFromForecastEntity> weather;

  ListElementEntity({
    required this.dt,
    required this.main,
    required this.weather,
  });
}

class MainClassEntity {
  final double tempMin;
  final double tempMax;

  MainClassEntity({
    required this.tempMin,
    required this.tempMax,
  });
}

class WeatherFromForecastEntity {
  final String icon;

  WeatherFromForecastEntity({
    required this.icon,
  });
}
