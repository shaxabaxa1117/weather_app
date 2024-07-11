import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/domain/model/weather_data.dart';
import 'package:weather_app/ui/widgets/blur_container.dart';
import 'package:weather_app/ui/widgets/home_page_appbar.dart';

class HomePage extends StatelessWidget {
  final WeatherData? weatherData;
  const HomePage({super.key, required this.weatherData});

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
        child: HomePageContent(
          dailyData: weatherData?.daily,
          current: weatherData?.current,
          timezone: weatherData?.timezone,
          timezoneOffset: weatherData?.timezoneOffset ?? 0,
        ),
      ),
    );
  }
}

class HomePageContent extends StatelessWidget {
  
  final Current? current;
  final String? timezone;
  final int timezoneOffset;
  final List<Daily>? dailyData;

  const HomePageContent({
    super.key,
    required this.current,
    required this.timezone,
    required this.timezoneOffset, required this.dailyData,
  });
  

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        HomePageAppBar(
          timezone: timezone,
        ),
        SizedBox(height: 32),
        HomePageHeader(
          dt: current?.dt != null ? current!.dt! : 0,
          timezoneOffset: timezoneOffset,
          
        ),
        SizedBox(height: 20),
        HomePageBody(
            currentTemp: current?.temp ?? 0.0,
            description: current?.weather?[0].description ?? 'Error'),
        SizedBox(height: 60),
        HomePageOptions(
          humidity: current?.humidity!.toDouble() ?? 0.0,
          feelsLike: current?.feelsLike ?? 0.0,
          windSpeed: current?.windSpeed ?? 0.0,
        ),
        SizedBox(height: 20),
        HomePageDailyData(dailyData: dailyData,),
      ],
    );
  }
}

class HomePageHeader extends StatelessWidget {
  final int dt;
  final int timezoneOffset;
  
  const HomePageHeader({
    super.key,
    required this.dt,
    required this.timezoneOffset,
  });

  @override
  Widget build(BuildContext context) {
    String timeStamp(String type) {
      print(dt);
      final String result = type == 'date'
          ? DateFormat('dd/MM/yyyy').format(
              DateTime.fromMillisecondsSinceEpoch(
                
                dt * 1000,
                
              ),
            )
          : type == 'time'
              ? DateFormat('HH:mm').format(
                  DateTime.fromMillisecondsSinceEpoch(
                    
                    (dt * 1000),
                  ),
                )
              : type == 'month' ? DateFormat.MMMM('ru').format(DateTime.fromMillisecondsSinceEpoch((dt * 1000))) : type == 'day' ?
              DateFormat.d('ru').format(DateTime.fromMillisecondsSinceEpoch((dt * 1000))) : 'error';
            
            return result;
    }
    

    return Column(
      children: [
        Text(
          ' ${timeStamp('month').capitalize} ${timeStamp('day')}',
          style: TextStyle(
            fontSize: 40,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Обнавлено ${timeStamp('date')} ${timeStamp('time')}',
          style: TextStyle(
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
  const HomePageCurrentWeatherInfo(
      {super.key, required this.currentTemp, required this.description});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          description.capitalize,
          style: TextStyle(
            fontSize: 40,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          '${currentTemp.round()}ºC' ?? '0.0',
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
  final double? humidity;
  final double? windSpeed;
  final double? feelsLike;
  const HomePageOptions(
      {super.key,
      required this.humidity,
      required this.windSpeed,
      required this.feelsLike});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> data = [
      {
        'img': 'assets/icons/humidity.svg',
        'title': 'Влажность',
        'data': '${humidity}%',
      },
      {
        'img': 'assets/icons/wind.svg',
        'title': 'Скорость ветра',
        'data': '${windSpeed} km/h',
      },
      {
        'img': 'assets/icons/feels_like.svg',
        'title': 'Ощущается',
        'data': '${feelsLike?.round()} ºC',
      },
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: BlurContainer(
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
  const HomePageDailyData({super.key, required this.dailyData,});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: BlurContainer(
        child: SizedBox(
          height: 118,
          width: double.infinity,
          child: ListView.separated(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) =>  HomePageDailyDataItem(item: dailyData?[index],),
            separatorBuilder: (context, index) => const SizedBox(width: 16),
            itemCount: dailyData?.length ?? 0,
          ),
        ),
      ),
    );
  }
}

class HomePageDailyDataItem extends StatelessWidget {
  const HomePageDailyDataItem({super.key,required this.item});
 final Daily? item;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
          ),
          Text('Wed 16'),
          Text('Wed 16')
        ],
      ),
    );
  }
}
