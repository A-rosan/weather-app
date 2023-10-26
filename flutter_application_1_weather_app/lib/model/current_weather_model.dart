// To parse this JSON data, do
//
//     final currentWeatherM = currentWeatherMFromMap(jsonString);

import 'dart:convert';

CurrentWeatherM currentWeatherMFromMap(String str) =>
    CurrentWeatherM.fromMap(json.decode(str));

String currentWeatherMToMap(CurrentWeatherM data) => json.encode(data.toMap());

class CurrentWeatherM {
  Coord? coord;
  List<Weather>? weather;
  String? base;
  Main? main;
  num? visibility;
  Wind? wind;
  Clouds? clouds;
  num? dt;
  Sys? sys;
  num? timezone;
  num? id;
  String? name;
  num? cod;

  CurrentWeatherM({
    this.coord,
    this.weather,
    this.base,
    this.main,
    this.visibility,
    this.wind,
    this.clouds,
    this.dt,
    this.sys,
    this.timezone,
    this.id,
    this.name,
    this.cod,
  });

  factory CurrentWeatherM.fromMap(Map<String, dynamic> json) => CurrentWeatherM(
        coord: Coord.fromMap(json["coord"]),
        weather:
            List<Weather>.from(json["weather"].map((x) => Weather.fromMap(x))),
        base: json["base"],
        main: Main.fromMap(json["main"]),
        visibility: json["visibility"],
        wind: Wind.fromMap(json["wind"]),
        clouds: Clouds.fromMap(json["clouds"]),
        dt: json["dt"],
        sys: Sys.fromMap(json["sys"]),
        timezone: json["timezone"],
        id: json["id"],
        name: json["name"],
        cod: json["cod"],
      );

  Map<String, dynamic> toMap() => {
        "coord": coord?.toMap(),
        "weather": List<dynamic>.from(weather?.map((x) => x.toMap()) ?? []),
        "base": base,
        "main": main?.toMap(),
        "visibility": visibility,
        "wind": wind?.toMap(),
        "clouds": clouds?.toMap(),
        "dt": dt,
        "sys": sys?.toMap(),
        "timezone": timezone,
        "id": id,
        "name": name,
        "cod": cod,
      };
}

class Clouds {
  num? all;

  Clouds({
    this.all,
  });

  factory Clouds.fromMap(Map<String, dynamic> json) => Clouds(
        all: json["all"],
      );

  Map<String, dynamic> toMap() => {
        "all": all,
      };
}

class Coord {
  num? lon;
  num? lat;

  Coord({
    this.lon,
    this.lat,
  });

  factory Coord.fromMap(Map<String, dynamic> json) => Coord(
        lon: json["lon"],
        lat: json["lat"],
      );

  Map<String, dynamic> toMap() => {
        "lon": lon,
        "lat": lat,
      };
}

class Main {
  num? temp;
  num? feelsLike;
  num? tempMin;
  num? tempMax;
  num? pressure;
  num? humidity;

  Main({
    this.temp,
    this.feelsLike,
    this.tempMin,
    this.tempMax,
    this.pressure,
    this.humidity,
  });

  factory Main.fromMap(Map<String, dynamic> json) => Main(
        temp: json["temp"],
        feelsLike: json["feels_like"],
        tempMin: json["temp_min"],
        tempMax: json["temp_max"],
        pressure: json["pressure"],
        humidity: json["humidity"],
      );

  Map<String, dynamic> toMap() => {
        "temp": temp,
        "feels_like": feelsLike,
        "temp_min": tempMin,
        "temp_max": tempMax,
        "pressure": pressure,
        "humidity": humidity,
      };
}

class Sys {
  num? type;
  num? id;
  String? country;
  num? sunrise;
  num? sunset;

  Sys({
    this.type,
    this.id,
    this.country,
    this.sunrise,
    this.sunset,
  });

  factory Sys.fromMap(Map<String, dynamic> json) => Sys(
        type: json["type"],
        id: json["id"],
        country: json["country"],
        sunrise: json["sunrise"],
        sunset: json["sunset"],
      );

  Map<String, dynamic> toMap() => {
        "type": type,
        "id": id,
        "country": country,
        "sunrise": sunrise,
        "sunset": sunset,
      };
}

class Weather {
  num? id;
  String? main;
  String? description;
  String? icon;

  Weather({
    this.id,
    this.main,
    this.description,
    this.icon,
  });

  factory Weather.fromMap(Map<String, dynamic> json) => Weather(
        id: json["id"],
        main: json["main"],
        description: json["description"],
        icon: json["icon"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "main": main,
        "description": description,
        "icon": icon,
      };
}

class Wind {
  num? speed;
  num? deg;

  Wind({
    this.speed,
    this.deg,
  });

  factory Wind.fromMap(Map<String, dynamic> json) => Wind(
        speed: json["speed"],
        deg: json["deg"],
      );

  Map<String, dynamic> toMap() => {
        "speed": speed,
        "deg": deg,
      };
}
