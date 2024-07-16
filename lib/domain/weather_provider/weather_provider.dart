import 'package:flutter/material.dart';
import 'package:weather_app/domain/api/api.dart';
import 'package:weather_app/domain/model/weather_data.dart';

final class WeatherProvider extends ChangeNotifier {
  WeatherData? _weatherData;
  WeatherData? get weatherData => _weatherData;

  Future<WeatherData?>? setUp() async {
    await Future.delayed(const Duration(seconds: 3));
    _weatherData = await Api.getWeatherData();
    return _weatherData;
  }

  String? _icon;

  String? get icon => _icon;

  String setIcon(int condition) {
    if (condition >= 200 && condition <= 232) {
      return 'assets/icons/strom_icon.svg';
    } else if (condition >= 300 && condition <= 321) {
      return 'assets/icons/rain_icon.svg';
    } else if (condition >= 500 && condition <= 531) {
      return 'assets/icons/rain_icon.svg';
    } else if (condition >= 600 && condition <= 622) {
      return 'assets/icons/snow_icon.svg';
    } else if (condition >= 701 && condition <= 781) {
      return 'assets/icons/strom_icon.svg';
    } else if (condition >= 801 && condition <= 804) {
      return 'assets/icons/clear_icon.svg';
    } else if (condition == 800) {
      return 'assets/icons/clear_icon.svg';
    } else {
      return '';
    }
  }
}
