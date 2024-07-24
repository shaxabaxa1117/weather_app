import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/domain/weather_provider/weather_provider.dart';
import 'package:weather_app/ui/pages/favorites_page.dart';

class HomePageAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? timeZone;
  const HomePageAppBar({
    super.key,
    this.timeZone,
  });

  @override
  Widget build(BuildContext context) {
    final WeatherProvider model = Provider.of<WeatherProvider>(context);
    return AppBar(
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      leadingWidth: 200,
      leading: TextButton.icon(
        onPressed: () {
          showBottomSheet(context: context, builder: (context) => SearchPage());
        },
        label: Text(
          timeZone ?? 'Error',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
        icon: const Icon(
          Icons.location_on,
          color: Colors.white,
          size: 32,
        ),
      ),
      actions: <Widget>[
        IconButton(
          onPressed: () {
            model.addFavorite(context);
          },
          color: Colors.red,
          icon: const Icon(Icons.favorite),
        ),
        IconButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const FavoritesPage(),
              ),
            );
          },
          iconSize: 32,
          color: Colors.white,
          icon: const Icon(Icons.menu),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, 96);
}

class SearchPage extends StatelessWidget {
  const SearchPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<WeatherProvider>(context);
    return SafeArea(
        child: Column(
      children: [
        const SizedBox(
          height: 48,
        ),
        Container(
          padding: const EdgeInsets.all(20),
          child:  TextField(
            controller: model.cityController,
            decoration: const InputDecoration(
              hintText: 'Ввидите название города',
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none)),
                    
          ),
        ),
        const Spacer(),
        FloatingActionButton.extended(
          backgroundColor: Colors.lightBlue,
          
          onPressed: () {
            model.searchCity(context: context);
          },
          label: const Text('Показать', style: TextStyle(color: Colors.white),),
        ),
        const SizedBox(
          height: 48,
        ),
      ],
    ));
  }
}
