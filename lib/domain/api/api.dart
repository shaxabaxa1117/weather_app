import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_app/domain/models/coords.dart';
import 'package:weather_app/domain/models/weather_data.dart';

abstract final class Api {
  static const String _apiKey = '49cc8c821cd2aff9af04c9f98c36eb74';
  static Future<Coords?>? getCoords({String cityName = 'Tashkent'}) async {
    try {
      final http.Response response = await http.get(
        Uri.parse(
          'http://api.openweathermap.org/geo/1.0/direct?q=$cityName&appid=$_apiKey',
        ),
      );
      final jsonData = json.decode(response.body);
      final Coords coords = Coords.fromJson(jsonData);
      
      return coords;
    } catch (e) {
      e;
    }
    return null;
  }

  static Future<WeatherData?>? getWeatherData({String cityName = 'Tashkent'}) async {
    final Coords? coords = await getCoords(cityName: cityName);

    final http.Response response = await http.get(
      Uri.parse(
        'https://api.openweathermap.org/data/2.5/onecall?lat=${coords!.lat}&lon=${coords.lon}&exclude=hourly,minutely&appid=$_apiKey&units=metric&lang=ru',
      ),
    );
    final jsonData = await json.decode(response.body);
    WeatherData weatherData = WeatherData.fromJson(jsonData);
    return weatherData;
  }

  
}
