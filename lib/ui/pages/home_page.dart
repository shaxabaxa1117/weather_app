// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:weather_app/ui/widgets/home_page_appbar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      drawer: Drawer(),
      body: Expanded(
        child: Container(
          width: size.width,
          height: size.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/paris.png'),
                fit: BoxFit.cover),
          ),
          child: Column(
            children: <Widget>[
              const HomePageAppBar(),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  children: const <Widget>[
                    SizedBox(
                      height: 60,
                    ),
                    HomePageHeader(),
                    SizedBox(
                      height: 50,
                    ),
                    HomePageFirstBody(),
                    SizedBox(
                      height: 25,
                    ),
                    HomePageSecondBody()
                  ],
                ),
              )
            ],
          ),
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
              fontSize: 40, color: Colors.white, fontWeight: FontWeight.w500),
        ),
        SizedBox(
          height: 8,
        ),
        Text(
          'Update 6/7/2024 4:55 PM',
          style: TextStyle(color: Colors.white,fontSize: 16),
        )
      ],
    );
  }
}

class HomePageFirstBody extends StatelessWidget {
  const HomePageFirstBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Image(
          image: AssetImage('assets/icons/sun.png'),
          height: 95,
          width: 95,
        ),
        Text(
          'Clear',
          style: TextStyle(
              color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),
        ),
        NumCel()
      ],
    );
  }
}

class NumCel extends StatelessWidget {
  const NumCel({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 25),
      height: 120,
      width: 140,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Text(
              '40',
              style: TextStyle(fontSize: 80, color: Colors.white),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            child: Image(
              image: AssetImage('assets/icons/cel.png'),
              color: Colors.white,
              height: 35,
              width: 35,
            ),
          )
        ],
      ),
    );
  }
}

class HomePageSecondBody extends StatelessWidget {
  const HomePageSecondBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ComponentOfSwcondBody(
            name: 'Humidity',
            icon: Icons.water_drop_outlined,
            numDescription: '56%',
          ),
          ComponentOfSwcondBody(
            name: 'Wind',
            icon: Icons.air,
            numDescription: '5.14km/h',
          ),
          ComponentOfSwcondBody(
            name: 'feels like',
            icon: Icons.thermostat_rounded,
            numDescription: '28',
          ),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class ComponentOfSwcondBody extends StatelessWidget {
  ComponentOfSwcondBody({
    super.key,
    required this.name,
    required this.icon,
    required this.numDescription,
  });
  String name;
  IconData icon;
  String numDescription;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Icon(
            icon,
            size: 30,
            color: Colors.white,
          ),
          Text(
            name.toUpperCase(),
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
          Text(
            numDescription,
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
