// To parse this JSON data, do
//
//     final weatherDayModelClass = weatherDayModelClassFromJson(jsonString);

import 'dart:convert';

WeatherDayModelClass weatherDayModelClassFromJson(String str) => WeatherDayModelClass.fromJson(json.decode(str));

// String weatherDayModelClassToJson(WeatherDayModelClass data) => json.encode(data.toJson());

class WeatherDayModelClass {
    WeatherDayModelClass({
         this.cod,
         this.message,
         this.cnt,
       required  this.list,
         this.city,
    });

    String? cod;
    int? message;
    int? cnt;
    List<ListElement> list;
    City? city;

    factory WeatherDayModelClass.fromJson(Map<String, dynamic> json) => WeatherDayModelClass(
        cod: json["cod"],
        message: json["message"],
        cnt: json["cnt"],
        list: List<ListElement>.from(json["list"].map((x) => ListElement.fromJson(x))),
        city: City.fromJson(json["city"]),
    );

   
}

class City {
    City({
        required this.id,
        required this.name,
        required this.coord,
        required this.country,
        required this.population,
        required this.timezone,
        required this.sunrise,
        required this.sunset,
    });

    int id;
    String name;
    Coord coord;
    String country;
    int population;
    int timezone;
    int sunrise;
    int sunset;

    factory City.fromJson(Map<String, dynamic> json) => City(
        id: json["id"],
        name: json["name"],
        coord: Coord.fromJson(json["coord"]),
        country: json["country"],
        population: json["population"],
        timezone: json["timezone"],
        sunrise: json["sunrise"],
        sunset: json["sunset"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "coord": coord.toJson(),
        "country": country,
        "population": population,
        "timezone": timezone,
        "sunrise": sunrise,
        "sunset": sunset,
    };
}

class Coord {
    Coord({
        required this.lat,
        required this.lon,
    });

    double lat;
    double lon;

    factory Coord.fromJson(Map<String, dynamic> json) => Coord(
        lat: json["lat"]?.toDouble(),
        lon: json["lon"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "lat": lat,
        "lon": lon,
    };
}

class ListElement {
    ListElement({
        required this.dt,
        required this.main,
        required this.weather,
        required this.clouds,
        required this.wind,
        required this.visibility,
        required this.pop,
        // required this.sys,
        required this.dtTxt,
        this.rain,
    });

    int dt;
    MainClass main;
    List<Weather> weather;
    Clouds clouds;
    Wind wind;
    int visibility;
    double pop;
    // Sys sys;
    DateTime dtTxt;
    Rain? rain;

    factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
        dt: json["dt"],
        main: MainClass.fromJson(json["main"]),
        weather: List<Weather>.from(json["weather"].map((x) => Weather.fromJson(x))),
        clouds: Clouds.fromJson(json["clouds"]),
        wind: Wind.fromJson(json["wind"]),
        visibility: json["visibility"],
        pop: json["pop"]?.toDouble(),
        // sys: Sys.fromJson(json["sys"]),
        dtTxt: DateTime.parse(json["dt_txt"]),
        rain: json["rain"] == null ? null : Rain.fromJson(json["rain"]),
    );

   
}

class Clouds {
    Clouds({
        required this.all,
    });

    int all;

    factory Clouds.fromJson(Map<String, dynamic> json) => Clouds(
        all: json["all"],
    );

    Map<String, dynamic> toJson() => {
        "all": all,
    };
}

class MainClass {
    MainClass({
        required this.temp,
        required this.feelsLike,
        required this.tempMin,
        required this.tempMax,
        required this.pressure,
        required this.seaLevel,
        required this.grndLevel,
        required this.humidity,
        required this.tempKf,
    });

    int temp;
    double feelsLike;
    int tempMin;
    int tempMax;
    int pressure;
    int seaLevel;
    int grndLevel;
    int humidity;
    double tempKf;

    factory MainClass.fromJson(Map<String, dynamic> json) => MainClass(
        temp: json["temp"],
        feelsLike: json["feels_like"]?.toDouble(),
        tempMin: json["temp_min"],
        tempMax: json["temp_max"],
        pressure: json["pressure"],
        seaLevel: json["sea_level"],
        grndLevel: json["grnd_level"],
        humidity: json["humidity"],
        tempKf: json["temp_kf"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
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

class Rain {
    Rain({
        required this.the3H,
    });

    double the3H;

    factory Rain.fromJson(Map<String, dynamic> json) => Rain(
        the3H: json["3h"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "3h": the3H,
    };
}


enum Pod { N, D }


class Weather {
    Weather({
        required this.id,
        // required this.main,
        // required this.description,
        required this.icon,
    });

    int id;
    // MainEnum main;
    // Description description;
    String icon;

    factory Weather.fromJson(Map<String, dynamic> json) => Weather(
        id: json["id"],
        // main: json["main"]!,
        // description: descriptionValues.map[json["description"]]!,
        icon: json["icon"],
    );

 
}

enum Description { FEW_CLOUDS, BROKEN_CLOUDS, SCATTERED_CLOUDS, CLEAR_SKY, OVERCAST_CLOUDS, LIGHT_RAIN }

enum MainEnum { CLOUDS, CLEAR, RAIN }


class Wind {
    Wind({
        required this.speed,
        required this.deg,
        required this.gust,
    });

    double speed;
    int deg;
    double gust;

    factory Wind.fromJson(Map<String, dynamic> json) => Wind(
        speed: json["speed"]?.toDouble(),
        deg: json["deg"],
        gust: json["gust"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "speed": speed,
        "deg": deg,
        "gust": gust,
    };
}


