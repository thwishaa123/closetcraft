import 'package:closet_craft_project/features/calendar/calendar_screen.dart';
import 'package:closet_craft_project/features/closet/pages/closet.dart';
import 'package:closet_craft_project/features/profile/pages/profile.dart';
import 'package:closet_craft_project/features/weather/weather_screen.dart';
import 'package:closet_craft_project/utils/responsive_utils.dart';
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
    final isIPhoneProMax = context.isIPhoneProMax;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        heroTag: 'HomeFAB',
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AddCloset()),
        ),
        backgroundColor: Colors.indigo,
        mini: true,
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: context.responsiveIconSize(20),
        ),
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
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.indigo,
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: context.responsiveTextStyle(
          fontSize: isIPhoneProMax ? 14 : 12,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: context.responsiveTextStyle(
          fontSize: isIPhoneProMax ? 12 : 10,
        ),
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/closet.png',
              width: context.responsiveIconSize(27),
            ),
            label: 'Closet',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.sunny,
              color: Colors.black,
              size: context.responsiveIconSize(24),
            ),
            label: 'Weather',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.calendar_month_outlined,
              color: Colors.black,
              size: context.responsiveIconSize(24),
            ),
            label: 'Calendar',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              color: Colors.black,
              size: context.responsiveIconSize(24),
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
