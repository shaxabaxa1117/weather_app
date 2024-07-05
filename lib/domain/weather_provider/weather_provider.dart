import 'package:flutter/material.dart';
import 'package:weather_app/domain/api/api.dart';
import 'package:weather_app/domain/model/weather_data.dart';

final class WeatherProvider extends ChangeNotifier{

  WeatherData? _weatherData;
  WeatherData? get weatherData => _weatherData;

  Future<WeatherData?>? setUp() async{
    await Future.delayed(const Duration(seconds: 3));
    _weatherData = await Api.getWeatherData();
    return _weatherData;

  }

}





