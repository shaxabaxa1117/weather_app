import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:weather_app/domain/hive/favorite_model.dart';
import 'package:weather_app/domain/hive/hive_box.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Избранные'),
        centerTitle: true,
      ),
      body: ValueListenableBuilder(
        valueListenable: HiveBox.favotiresBox.listenable(),
        builder: (context, data, _) {
          final List<FavoriteModel> allFavorites = data.values.toList();
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemBuilder: (context, i) => FavoriteItem(
              cityName: allFavorites[i].cityName,
            ),
            separatorBuilder: (context, i) => const SizedBox(height: 16),
            itemCount: allFavorites.length,
          );
        },
      ),
    );
  }
}

class FavoriteItem extends StatelessWidget {
  final String cityName;
  const FavoriteItem({
    super.key,
    required this.cityName,
  });

  @override
  Widget build(BuildContext context) {
    String _favoriteCityName = cityName.split('/').last;

    return ListTile(
      onTap: () {},
      title: Text(_favoriteCityName),
      subtitle: const Text('Избранный город'),
    );
  }
}
