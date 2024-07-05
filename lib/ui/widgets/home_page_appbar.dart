import 'package:flutter/material.dart';

class HomePageAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomePageAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      leadingWidth: 120,
      leading: TextButton.icon(
        onPressed: null,
        label: const Text(
          'Paris',
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
