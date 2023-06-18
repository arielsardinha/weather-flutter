class Weather {
  final List<WeatherElement> weather;
  final int visibility;
  final Main main;

  final Wind wind;

  final Sys sys;

  final String name;

  Weather({
    required this.weather,
    required this.main,
    required this.wind,
    required this.sys,
    required this.name,
    required this.visibility,
  });

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
        weather: List<WeatherElement>.from(
            json["weather"].map((x) => WeatherElement.fromJson(x))),
        main: Main.fromJson(json["main"]),
        wind: Wind.fromJson(json["wind"]),
        sys: Sys.fromJson(json["sys"]),
        name: json["name"],
        visibility: json["visibility"],
      );
}

class Main {
  final double? temp;

  final int humidity;

  Main({
    required this.temp,
    required this.humidity,
  });

  factory Main.fromJson(Map<String, dynamic> json) => Main(
        temp: json["temp"]?.toDouble(),
        humidity: json["humidity"],
      );
}

class Sys {
  final String? country;

  Sys({
    this.country,
  });

  factory Sys.fromJson(Map<String, dynamic> json) => Sys(
        country: json["country"],
      );
}

class WeatherElement {
  final String main;
  final String description;
  final String icon;

  WeatherElement({
    required this.main,
    required this.description,
    required this.icon,
  });

  factory WeatherElement.fromJson(Map<String, dynamic> json) => WeatherElement(
        main: json["main"],
        description: json["description"],
        icon: json["icon"],
      );
}

class Wind {
  final double speed;

  Wind({
    required this.speed,
  });

  factory Wind.fromJson(Map<String, dynamic> json) => Wind(
        speed: json["speed"]?.toDouble(),
      );
}
