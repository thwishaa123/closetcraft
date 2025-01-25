import 'package:closet_craft_project/calendar_screen.dart';
import 'package:closet_craft_project/closet.dart';
import 'package:closet_craft_project/profile.dart';
import 'package:closet_craft_project/weather_screen.dart';
import 'package:flutter/material.dart';



class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List <Widget> widgetList = [

    ClosetPage(),
    const WeatherScreen(),
    const CalendarScreen(),

    const ProfilePage(),
  ];
  int myIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        children: widgetList,
        index: myIndex,
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            myIndex = index;
          });
        },
        currentIndex: myIndex,
        items: [
          BottomNavigationBarItem(icon: (Image.asset('images/closet.png',width: 27,)), label: 'Closet'),
          const BottomNavigationBarItem(icon: Icon(Icons.sunny,color: Colors.black), label: 'Weather'),
          const BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month_outlined,color: Colors.black), label: 'Calendar'),

          const BottomNavigationBarItem(icon: Icon(Icons.person,color: Colors.black,), label: 'Profile,'),

          //BottomNavigationBarItem(
          // icon: Icon(Icons.),
          //label: 'Closet'),
        ],
      ),
    );
  }
}
