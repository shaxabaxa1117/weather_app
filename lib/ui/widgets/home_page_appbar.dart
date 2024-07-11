import 'package:flutter/material.dart';
import 'package:weather_app/domain/model/weather_data.dart';

class HomePageAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? timezone;
  const HomePageAppBar({super.key, required this.timezone, });
  
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      leadingWidth: 200,
      leading: TextButton.icon(
        onPressed: null,
        label:  Text(
          timezone ?? 'Error',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
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
          onPressed: () {},
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
