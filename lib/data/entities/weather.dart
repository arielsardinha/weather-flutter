class Weather {
  final List<WeatherElement> weather;
  final int _visibility;
  final Main main;
  final Wind wind;
  final Sys sys;
  final String name;
  final Coord coord;

  Weather({
    required this.weather,
    required this.main,
    required this.wind,
    required this.sys,
    required this.name,
    required int visibility,
    required this.coord,
  }) : _visibility = visibility;

  String get visibility {
    if (_visibility >= 10000) {
      return 'Excelente';
    } else if (_visibility >= 5000) {
      return 'Boa';
    } else if (_visibility >= 2000) {
      return 'Moderada';
    } else {
      return 'Baixa';
    }
  }

  String get visibilityMessage {
    if (_visibility >= 10000) {
      return 'Condições de estrada claras, dirija como de costume.';
    } else if (_visibility >= 5000) {
      return 'Condições de estrada decentes, mas fique atento.';
    } else if (_visibility >= 2000) {
      return 'Visibilidade reduzida, por favor, diminua a velocidade e mantenha uma distância segura dos outros veículos.';
    } else {
      return 'Visibilidade muito baixa, é altamente recomendável não dirigir, se possível.';
    }
  }

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
        weather: List<WeatherElement>.from(
            json["weather"].map((x) => WeatherElement.fromJson(x))),
        main: Main.fromJson(json["main"]),
        wind: Wind.fromJson(json["wind"]),
        sys: Sys.fromJson(json["sys"]),
        name: json["name"],
        visibility: json["visibility"],
        coord: Coord.fromJson(json["coord"]),
      );
}

class Coord {
  final double lon;
  final double lat;

  Coord({
    required this.lon,
    required this.lat,
  });

  factory Coord.fromJson(Map<String, dynamic> json) => Coord(
        lon: json["lon"]?.toDouble(),
        lat: json["lat"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "lon": lon,
        "lat": lat,
      };
}

class Main {
  final double? temp;
  final double? tempMin;
  final double? tempMax;
  final int humidity;

  Main({
    required this.temp,
    required this.humidity,
    required this.tempMin,
    required this.tempMax,
  });

  factory Main.fromJson(Map<String, dynamic> json) => Main(
        temp: json["temp"]?.toDouble(),
        humidity: json["humidity"],
        tempMin: json["temp_min"]?.toDouble(),
        tempMax: json["temp_max"]?.toDouble(),
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
