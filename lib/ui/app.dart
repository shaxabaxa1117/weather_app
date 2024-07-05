import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:flutter/services.dart';
import 'package:weather_app/domain/weather_provider/weather_provider.dart';
import 'package:weather_app/ui/pages/home_page.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: FlexColorScheme.themedSystemNavigationBar(
        context,
        systemNavBarStyle: FlexSystemNavBarStyle.transparent,
        noAppBar: false,
      ),
      child: ChangeNotifierProvider<WeatherProvider>(
        create: (context) => WeatherProvider(),
        child: MaterialApp(
          home: MyAppContent(),
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
      backgroundColor: const Color.fromRGBO(8, 108, 180, 1),
      duration: const Duration(seconds: 3),
      childWidget: const SplashScreenContent(),
      nextScreen: const HomePage(),
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
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
          children: <TextSpan>[
            TextSpan(text: 'Weather'),
            TextSpan(
              text: 'App',
              style: TextStyle(
                color: Colors.yellow,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
