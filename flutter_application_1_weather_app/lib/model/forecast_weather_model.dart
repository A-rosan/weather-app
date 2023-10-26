// To parse this JSON data, do
//
//     final forecastWeatherM = forecastWeatherMFromMap(jsonString);

import 'dart:convert';

ForecastWeatherM forecastWeatherMFromMap(String str) =>
    ForecastWeatherM.fromMap(json.decode(str));

String forecastWeatherMToMap(ForecastWeatherM data) =>
    json.encode(data.toMap());

class ForecastWeatherM {
  String? cod;
  num? message;
  num? cnt;
  List<ListElement>? list;
  City? city;

  ForecastWeatherM({
    this.cod,
    this.message,
    this.cnt,
    this.list,
    this.city,
  });

  factory ForecastWeatherM.fromMap(Map<String, dynamic> json) =>
      ForecastWeatherM(
        cod: json["cod"],
        message: json["message"],
        cnt: json["cnt"],
        list: List<ListElement>.from(
            json["list"].map((x) => ListElement.fromMap(x))),
        city: City.fromMap(json["city"]),
      );

  Map<String, dynamic> toMap() => {
        "cod": cod,
        "message": message,
        "cnt": cnt,
        "list": List<dynamic>.from(list!.map((x) => x.toMap())),
        "city": city!.toMap(),
      };
}

class City {
  num? id;
  String? name;
  Coord? coord;
  String? country;
  num? population;
  num? timezone;
  num? sunrise;
  num? sunset;

  City({
    this.id,
    this.name,
    this.coord,
    this.country,
    this.population,
    this.timezone,
    this.sunrise,
    this.sunset,
  });

  factory City.fromMap(Map<String, dynamic> json) => City(
        id: json["id"],
        name: json["name"],
        coord: Coord.fromMap(json["coord"]),
        country: json["country"],
        population: json["population"],
        timezone: json["timezone"],
        sunrise: json["sunrise"],
        sunset: json["sunset"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "coord": coord!.toMap(),
        "country": country,
        "population": population,
        "timezone": timezone,
        "sunrise": sunrise,
        "sunset": sunset,
      };
}

class Coord {
  num? lat;
  num? lon;

  Coord({
    this.lat,
    this.lon,
  });

  factory Coord.fromMap(Map<String, dynamic> json) => Coord(
        lat: json["lat"],
        lon: json["lon"],
      );

  Map<String, dynamic> toMap() => {
        "lat": lat,
        "lon": lon,
      };
}

class ListElement {
  num? dt;
  MainClass? main;
  List<Weather>? weather;
  Clouds? clouds;
  Wind? wind;
  num? visibility;
  num? pop;
  Sys? sys;
  DateTime? dtTxt;

  ListElement({
    this.dt,
    this.main,
    this.weather,
    this.clouds,
    this.wind,
    this.visibility,
    this.pop,
    this.sys,
    this.dtTxt,
  });

  factory ListElement.fromMap(Map<String, dynamic> json) => ListElement(
        dt: json["dt"],
        main: MainClass.fromMap(json["main"]),
        weather:
            List<Weather>.from(json["weather"].map((x) => Weather.fromMap(x))),
        clouds: Clouds.fromMap(json["clouds"]),
        wind: Wind.fromMap(json["wind"]),
        visibility: json["visibility"],
        pop: json["pop"],
        sys: Sys.fromMap(json["sys"]),
        dtTxt: DateTime.parse(json["dt_txt"]),
      );

  Map<String, dynamic> toMap() => {
        "dt": dt,
        "main": main!.toMap(),
        "weather": List<dynamic>.from(weather!.map((x) => x.toMap())),
        "clouds": clouds!.toMap(),
        "wind": wind!.toMap(),
        "visibility": visibility,
        "pop": pop,
        "sys": sys!.toMap(),
        "dt_txt": dtTxt!.toIso8601String(),
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

class MainClass {
  num? temp;
  num? feelsLike;
  num? tempMin;
  num? tempMax;
  num? pressure;
  num? seaLevel;
  num? grndLevel;
  num? humidity;
  num? tempKf;

//   ال api
//   كان يجيب مرات دبل و مرات انت لنفس الفاريبل
// num
// هذا تايب
// المهم
// لما تعمل كل اشي نلبل
// الدبل نلبل ما بتحتوي الانت نلبل
// عشان ما تنسا خليها
// المهم بالموديل حول كل اشي انت او دبل لنم
// دايما

  MainClass({
    this.temp,
    this.feelsLike,
    this.tempMin,
    this.tempMax,
    this.pressure,
    this.seaLevel,
    this.grndLevel,
    this.humidity,
    this.tempKf,
  });

  factory MainClass.fromMap(Map<String, dynamic> json) => MainClass(
        temp: json["temp"],
        feelsLike: json["feels_like"],
        tempMin: json["temp_min"],
        tempMax: json["temp_max"],
        pressure: json["pressure"],
        seaLevel: json["sea_level"],
        grndLevel: json["grnd_level"],
        humidity: json["humidity"],
        tempKf: json["temp_kf"],
      );

  Map<String, dynamic> toMap() => {
        "temp": temp,
        "feels_like": feelsLike,
        "temp_min": tempMin,
        "temp_max": tempMax,
        "pressure": pressure,
        "sea_level": seaLevel,
        "grnd_level": grndLevel,
        "humidity": humidity,
        "temp_kf": tempKf,
      };
}

class Sys {
  Pod? pod;

  Sys({
    this.pod,
  });

  factory Sys.fromMap(Map<String, dynamic> json) => Sys(
        pod: podValues.map[json["pod"]],
      );

  Map<String, dynamic> toMap() => {
        "pod": podValues.reverse[pod],
      };
}

enum Pod { D, N }

final podValues = EnumValues({"d": Pod.D, "n": Pod.N});

class Weather {
  num? id;
  MainEnum? main;
  Description? description;
  String? icon;

  Weather({
    this.id,
    this.main,
    this.description,
    this.icon,
  });

  factory Weather.fromMap(Map<String, dynamic> json) => Weather(
        id: json["id"],
        main: mainEnumValues.map[json["main"]],
        description: descriptionValues.map[json["description"]],
        icon: json["icon"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "main": mainEnumValues.reverse[main],
        "description": descriptionValues.reverse[description],
        "icon": icon,
      };
}

enum Description {
  BROKEN_CLOUDS,
  CLEAR_SKY,
  FEW_CLOUDS,
  OVERCAST_CLOUDS,
  SCATTERED_CLOUDS
}

final descriptionValues = EnumValues({
  "broken clouds": Description.BROKEN_CLOUDS,
  "clear sky": Description.CLEAR_SKY,
  "few clouds": Description.FEW_CLOUDS,
  "overcast clouds": Description.OVERCAST_CLOUDS,
  "scattered clouds": Description.SCATTERED_CLOUDS
});

enum MainEnum { CLEAR, CLOUDS }

final mainEnumValues =
    EnumValues({"Clear": MainEnum.CLEAR, "Clouds": MainEnum.CLOUDS});

class Wind {
  num? speed;
  num? deg;
  num? gust;

  Wind({
    this.speed,
    this.deg,
    this.gust,
  });

  factory Wind.fromMap(Map<String, dynamic> json) => Wind(
        speed: json["speed"],
        deg: json["deg"],
        gust: json["gust"],
      );

  Map<String, dynamic> toMap() => {
        "speed": speed,
        "deg": deg,
        "gust": gust,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
