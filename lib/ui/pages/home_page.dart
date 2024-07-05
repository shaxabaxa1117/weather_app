import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weather_app/ui/widgets/blur_container.dart';
import 'package:weather_app/ui/widgets/home_page_appbar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/paris.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: <Widget>[
            HomePageAppBar(),
            SizedBox(height: 32),
            HomePageHeader(),
            SizedBox(height: 20),
            HomePageBody(),
            SizedBox(height: 60),
            HomePageOptions(),
            SizedBox(height: 20),
            HomePageDailyData(),
          ],
        ),
      ),
    );
  }
}

class HomePageHeader extends StatelessWidget {
  const HomePageHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text(
          'June 07',
          style: TextStyle(
            fontSize: 40,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Updated 6/7/2023 4:55 PM',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}

class HomePageBody extends StatelessWidget {
  const HomePageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: <Widget>[
        HomePageCurrentWeatherInfo(),
      ],
    );
  }
}

class HomePageCurrentWeatherInfo extends StatelessWidget {
  const HomePageCurrentWeatherInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: <Widget>[
        Text(
          'Clear',
          style: TextStyle(
            fontSize: 40,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          '24ºC',
          style: TextStyle(
            fontSize: 86,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class HomePageOptions extends StatelessWidget {
  const HomePageOptions({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> data = [
      {
        'img': 'assets/icons/humidity.svg',
        'title': 'Humidity',
        'data': '56%',
      },
      {
        'img': 'assets/icons/wind.svg',
        'title': 'Wind',
        'data': '4.63 km/h',
      },
      {
        'img': 'assets/icons/feels_like.svg',
        'title': 'FEELS LIKE',
        'data': '56%',
      },
    ];

    return BlurContainer(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(
          data.length,
          (index) {
            return HomePageOptionsItem(
              imagePath: data[index]['img'],
              optionData: data[index]['data'],
              optionName: data[index]['title'],
            );
          },
        ),
      ),
    );
  }
}

class HomePageOptionsItem extends StatelessWidget {
  final String imagePath;
  final String optionName;
  final String optionData;
  const HomePageOptionsItem({
    super.key,
    required this.imagePath,
    required this.optionData,
    required this.optionName,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SvgPicture.asset(imagePath),
        const SizedBox(height: 8),
        Text(
          optionName.toUpperCase(),
          style: const TextStyle(
            fontSize: 14,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          optionData,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

class HomePageDailyData extends StatelessWidget {
  const HomePageDailyData({super.key});

  @override
  Widget build(BuildContext context) {
    return BlurContainer(
      child: SizedBox(
        height: 118,
        width: double.infinity,
        child: ListView.separated(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => const HomePageDailyDataItem(),
          separatorBuilder: (context, index) => const SizedBox(width: 16),
          itemCount: 7,
        ),
      ),
    );
  }
}

class HomePageDailyDataItem extends StatelessWidget {
  const HomePageDailyDataItem({super.key});

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      child: Column(
        children: <Widget>[
            const Text(
            'Wed 16',
            style: TextStyle(
              fontSize: 14,
              color: Colors.white,
            ),
          ),
          SvgPicture.asset(
            'assets/icons/weather.svg',
            width: 100,
            height: 50,
          )
        ],
      ),
    );
  }
}
