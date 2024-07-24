import 'package:hive/hive.dart';
import 'package:weather_app/domain/hive/favorite_model.dart';

abstract final class HiveBox {
  static final Box<FavoriteModel> favotiresBox =
      Hive.box<FavoriteModel>('FAVORITES');
}
