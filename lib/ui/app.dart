import 'dart:collection';

import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weather_app/ui/pages/home_page.dart';

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: FlexColorScheme.themedSystemNavigationBar(
        context,
        systemNavBarStyle: FlexSystemNavBarStyle.transparent,
        noAppBar: false,
      ),
      child: const MaterialApp(
        home: Scaffold(
          body: MyAppContent(),
        ),
      ),
    );
  }
}

class MyAppContent extends StatelessWidget {
  const MyAppContent({super.key});

  @override
  Widget build(BuildContext context) {
    return FlutterSplashScreen.fadeIn(
      backgroundColor: const Color.fromARGB(132, 27, 147, 245),
      duration: const Duration(seconds: 3),
      childWidget: const SplashScreenContent(),
      nextScreen: HomePage(),
    );
  }
}

class SplashScreenContent extends StatelessWidget {
  const SplashScreenContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RichText(
        text: const TextSpan(
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            children: <TextSpan>[
              TextSpan(
                text: 'Weather',
                style: TextStyle(
                  color: Colors.yellow,
                ),
              ),
              TextSpan(text: 'App')
            ]),
      ),
    );
  }
}
