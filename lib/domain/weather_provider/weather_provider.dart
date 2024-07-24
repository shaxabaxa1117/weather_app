import 'package:flutter/material.dart';
import 'package:weather_app/domain/api/api.dart';
import 'package:weather_app/domain/hive/favorite_model.dart';
import 'package:weather_app/domain/hive/hive_box.dart';
import 'package:weather_app/domain/models/weather_data.dart';

final class WeatherProvider extends ChangeNotifier {
  WeatherData? _weatherData;
  WeatherData? get weatherWeather => _weatherData;

  Future<WeatherData?>? setUp({String? cityName = 'Tashkent' }) async {
    await Future.delayed(const Duration(seconds: 3));
    _weatherData = await Api.getWeatherData();
    return _weatherData;
  }

  String? _icon;
  String? get icon => _icon;

  String setIcon(int condition) {
    if (condition >= 200 && condition <= 232) {
      return 'assets/icons/storm.svg';
    } else if (condition >= 300 && condition <= 321) {
      return 'assets/icons/rain.svg';
    } else if (condition >= 500 && condition <= 531) {
      return 'assets/icons/rain.svg';
    } else if (condition >= 600 && condition <= 622) {
      return 'assets/icons/snow.svg';
    } else if (condition >= 701 && condition <= 781) {
      // Добавить туман
      return 'assets/icons/storm.svg';
    } else if (condition >= 801 && condition <= 804) {
      return 'assets/icons/cloudy.svg';
    } else if (condition == 800) {
      return 'assets/icons/clear.svg';
    } else {
      return 'assets/icons/clear.svg';
    }
  }

  void addFavorite(BuildContext context) async {
    await HiveBox.favotiresBox
        .add(
      FavoriteModel(
        cityName: _weatherData?.timezone ?? '',
      ),
    )
        .then((value) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${_weatherData?.timezone} Добавлен в избранное'),
        ),
      );
    });
  }

  TextEditingController cityController = TextEditingController();
  
    Future<void> searchCity({String? cityName = 'Tashkent', required BuildContext context}) async {
      
  try{
    if(cityController.text.isNotEmpty){
      await setUp(cityName: cityController.text);
    }
  Navigator.of(context).pop();
  } catch(e){
    e;
  }

  }

}


