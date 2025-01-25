import 'package:flutter/material.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  int index = 0;
   int temp=25;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,

      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          setState(() {
            index = (index + 1);
          });
        },
        label: Text('Build an Outfit',style: TextStyle(fontSize: 15),),




      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Center(
              child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Left Section: Weather icon and temperature
            Row(
              children: [
                Icon(Icons.sunny),
                SizedBox(width: 4), // Space between the icon and text
                Text('temp'),
              ],
            ),

            // Center Section: Today text
            Text('< Today >'),

            // Right Section: Location icon and text
            Row(
              children: [
                Icon(Icons.location_on),
                SizedBox(width: 4), // Space between the icon and text
                Text('Location'),
              ],
            ),
          ],
        ),


            ),

            Column(
              children: [


              ],
            )
    ],
        ),

    ),);
  }
}
