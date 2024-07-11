import 'package:flutter/widgets.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:weather_app/domain/api/api.dart';
import 'package:weather_app/ui/app.dart';

Future <void> main(List<String> args) async{
  await Api.getWeatherData();
  await initializeDateFormatting('ru', null);
  runApp(const MyApp());
}
