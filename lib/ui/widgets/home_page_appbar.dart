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
        onPressed: () {},
        icon: const Icon(
          Icons.location_on,
          size: 32,
          color: Colors.white,
        ),
        label: const Text(
          'Paris',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
      actions: <Widget>[
        IconButton(
          onPressed: () {},
          icon:const Icon(
            Icons.menu,
            size: 32,
            color: Colors.white,
          ),
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, 96);
}
