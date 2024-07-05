import 'dart:convert';

import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/domain/model/coords.dart';

abstract final class Api {
  static const String _apiKey = 'a24ba1c3e5e3d0acd60dfad4f5eb7e6e';


  static Future<Coords?> getCoords({String cityName = 'Tashkent'}) async {
    try {
      final http.Response response = await http.get(
        Uri.parse(
            'http://api.openweathermap.org/geo/1.0/direct?q=$cityName&appid=$_apiKey'),
      );
      
      final jsonData = json.decode(response.body);
      final Coords coords = Coords.fromJson(jsonData);
      print(coords.lat);
      print(coords.lon);
      print(response.body);
      return coords;
      
    } catch (e) {}
  }

  static Future<void> getWeatherData() async{
    try{
final Coords? coords = await getCoords();
      /* 
      https://api.openweathermap.org/data/3.0/onecall?lat={lat}&lon={lon}&exclude={part}&appid={API key} */
    
    final http.Response response = await http.get(
        Uri.parse(
            'https://api.openweathermap.org/data/3.0/onecall?lat=${coords?.lat.toString()}&lon=${coords?.lon.toString()}&appid=$_apiKey'),
      );
      final jsonData = json.decode(response.body);
      print(response.body);
    }catch(e){
e;
    }
  }
}
