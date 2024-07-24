import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:weather_app/domain/hive/favorite_model.dart';
import 'package:weather_app/ui/app.dart';

Future<void> main(List<String> args) async {
  await initializeDateFormatting('ru-RU', null);

  await Hive.initFlutter();

  Hive.registerAdapter(FavoriteModelAdapter());
  await Hive.openBox<FavoriteModel>('FAVORITES');
  runApp(const MyApp());
}
