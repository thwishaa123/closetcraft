import 'package:closet_craft_project/features/calendar/calendar_screen.dart';
import 'package:closet_craft_project/features/closet/pages/closet.dart';
import 'package:closet_craft_project/features/profile/pages/profile.dart';
import 'package:closet_craft_project/features/weather/weather_screen.dart';
import 'package:flutter/material.dart';
import '../closet/pages/add_closet.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Widget> widgetList = [
    const ClosetPage(),
    const WeatherScreen(),
    const CalendarScreen(),
    const ProfilePage(),
  ];
  int myIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        heroTag: 'HomeFAB',
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AddCloset()),
        ),
        backgroundColor: Colors.indigo,
        mini: true,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: widgetList.elementAt(myIndex),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            myIndex = index;
          });
        },
        currentIndex: myIndex,
        items: [
          BottomNavigationBarItem(
              icon: (Image.asset(
                'assets/images/closet.png',
                width: 27,
              )),
              label: 'Closet'),
          const BottomNavigationBarItem(
              icon: Icon(Icons.sunny, color: Colors.black), label: 'Weather'),
          const BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month_outlined, color: Colors.black),
              label: 'Calendar'),

          const BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                color: Colors.black,
              ),
              label: 'Profile,'),

          //BottomNavigationBarItem(
          // icon: Icon(Icons.),
          //label: 'Closet'),
        ],
      ),
    );
  }
}
