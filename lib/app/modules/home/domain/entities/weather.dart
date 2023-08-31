class WeatherEntity {
  final List<WeatherElementEntity> weather;
  final String visibility, visibilityMessage;
  final MainEntity main;
  final WindEntity wind;
  final SysEntity sys;
  final String name;
  final CoordEntity coord;
  final DateTime dateTime;

  WeatherEntity({
    required this.weather,
    required this.main,
    required this.wind,
    required this.sys,
    required this.name,
    required this.visibility,
    required this.coord,
    required this.dateTime,
    required this.visibilityMessage,
  });
}

class CoordEntity {
  final double lon;
  final double lat;

  CoordEntity({
    required this.lon,
    required this.lat,
  });
}

class MainEntity {
  final double? temp;
  final double? tempMin;
  final double? tempMax;
  final int humidity;

  MainEntity({
    required this.temp,
    required this.humidity,
    required this.tempMin,
    required this.tempMax,
  });
}

class SysEntity {
  final String? country;

  SysEntity({
    this.country,
  });
}

class WeatherElementEntity {
  final String main;
  final String description;
  final String icon;

  WeatherElementEntity({
    required this.main,
    required this.description,
    required this.icon,
  });
}

class WindEntity {
  final double speed;

  WindEntity({
    required this.speed,
  });
}
