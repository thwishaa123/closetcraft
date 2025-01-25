import 'package:closet_craft_project/bottom_navigation.dart';
import 'package:closet_craft_project/calendar_screen.dart';
import 'package:closet_craft_project/firebase_options.dart';
import 'package:closet_craft_project/profile.dart';
import 'package:closet_craft_project/signup.dart';
import 'package:closet_craft_project/weather_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'login.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
  //runApp(signApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App name',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),

      home: const HomeScreen(), // first page when app opens
    );
  }
}
