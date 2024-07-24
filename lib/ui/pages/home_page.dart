import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/domain/models/weather_data.dart';
import 'package:weather_app/domain/weather_provider/weather_provider.dart';
import 'package:weather_app/ui/widgets/blur_container.dart';
import 'package:weather_app/ui/widgets/home_page_app_bar.dart';

class HomePage extends StatelessWidget {
  final WeatherData? weatherData;
  const HomePage({
    super.key,
    required this.weatherData,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg.jfif'),
            fit: BoxFit.cover,
          ),
        ),
        child: HomePageContent(
          current: weatherData?.current,
          timeZone: weatherData?.timezone,
          timeZoneOffset: weatherData?.timezoneOffset ?? 0,
          dailyData: weatherData?.daily,
        ),
      ),
    );
  }
}

class HomePageContent extends StatelessWidget {
  final Current? current;
  final String? timeZone;
  final int timeZoneOffset;
  final List<Daily>? dailyData;
  const HomePageContent({
    super.key,
    required this.current,
    this.timeZone,
    required this.timeZoneOffset,
    required this.dailyData,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        HomePageAppBar(
          timeZone: timeZone,
        ),
        Expanded(
          child: ListView(
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 24),
            children: <Widget>[
              const SizedBox(height: 32),
              HomePageHeader(
                dt: current?.dt != null ? current!.dt! : 0,
                timeZoneOffset: timeZoneOffset,
                weatherId: current?.weather?[0].id ?? 0,
              ),
              const SizedBox(height: 20),
              HomePageBody(
                currentTemp: current?.temp ?? 0.0,
                description: current?.weather?[0].description ?? 'Error',
              ),
              const SizedBox(height: 60),
              HomePageOptions(
                feelsLike: current?.feelsLike ?? 0.0,
                windSpeed: current?.windSpeed ?? 0.0,
                humidity: current?.humidity!.toDouble() ?? 0.0,
              ),
              const SizedBox(height: 20),
              HomePageDailyData(
                dailyData: dailyData,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class HomePageHeader extends StatelessWidget {
  final int dt;
  final int timeZoneOffset;
  final int weatherId;
  const HomePageHeader({
    super.key,
    required this.dt,
    required this.timeZoneOffset,
    required this.weatherId,
  });

  @override
  Widget build(BuildContext context) {
    String timeStamp(String type) {
      final String result = type == 'date'
          ? DateFormat('dd/MM/yyyy')
              .format(DateTime.fromMillisecondsSinceEpoch(dt * 1000))
          : type == 'time'
              ? DateFormat('HH:mm').format(DateTime.fromMillisecondsSinceEpoch(
                  (dt + timeZoneOffset) * 1000))
              : 'Error';

      return result;
    }

    final WeatherProvider model = context.read<WeatherProvider>();
    return Column(
      children: [
        const Text(
          'June 07',
          style: TextStyle(
            fontSize: 40,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        SvgPicture.asset(
          model.setIcon(weatherId),
          width: 60,
          height: 60,
        ),
        Text(
          'Обновлено ${timeStamp('date')} ${timeStamp('time')} PM',
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}

class HomePageBody extends StatelessWidget {
  final double currentTemp;
  final String description;
  const HomePageBody({
    super.key,
    required this.currentTemp,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        HomePageCurrentWeatherInfo(
          currentTemp: currentTemp,
          description: description,
        ),
      ],
    );
  }
}

class HomePageCurrentWeatherInfo extends StatelessWidget {
  final double currentTemp;
  final String description;
  const HomePageCurrentWeatherInfo({
    super.key,
    required this.currentTemp,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          description.capitalize,
          style: const TextStyle(
            fontSize: 40,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          '${currentTemp.round()}ºC',
          style: const TextStyle(
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
  final double humidity;
  final double windSpeed;
  final double feelsLike;
  const HomePageOptions({
    super.key,
    required this.feelsLike,
    required this.windSpeed,
    required this.humidity,
  });

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> data = [
      {
        'img': 'assets/icons/humidity.svg',
        'title': 'Влажность',
        'data': '$humidity%',
      },
      {
        'img': 'assets/icons/wind.svg',
        'title': 'Скорость ветра',
        'data': '$windSpeed km/h',
      },
      {
        'img': 'assets/icons/feels-like.svg',
        'title': 'Ощущается',
        'data': '${feelsLike.round()} ºC',
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
  final List<Daily>? dailyData;
  const HomePageDailyData({
    super.key,
    required this.dailyData,
  });

  @override
  Widget build(BuildContext context) {
    return BlurContainer(
      child: SizedBox(
        height: 112,
        child: ListView.separated(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => HomePageDailyDataItem(
            item: dailyData?[index],
          ),
          separatorBuilder: (context, index) => const SizedBox(
            width: 16,
          ),
          itemCount: dailyData?.length ?? 0,
        ),
      ),
    );
  }
}

class HomePageDailyDataItem extends StatelessWidget {
  final Daily? item;
  const HomePageDailyDataItem({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    String timeStamp(String type) {
      final String result = type == 'day'
          ? DateFormat(
              'MMMM',
            ).format(
              DateTime.fromMillisecondsSinceEpoch(item!.dt! * 1000),
            )
          : type == 'date'
              ? DateFormat(
                  'dd',
                ).format(
                  DateTime.fromMillisecondsSinceEpoch(item!.dt! * 1000),
                )
              : 'Error';

      return result;
    }

    final WeatherProvider model = context.read<WeatherProvider>();
    return SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            '${timeStamp('day')} ${timeStamp('date')}',
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white,
            ),
          ),
          SvgPicture.asset(
            model.setIcon(item!.weather![0].id!),
            width: 40,
            height: 40,
          ),
          Text(
            '${item?.temp?.day?.round().toString()}ºC',
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
