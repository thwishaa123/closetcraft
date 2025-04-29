import 'package:closet_craft_project/features/bottom_navigation/bottom_navigation.dart';
import 'package:closet_craft_project/features/closet/provider/closet_provider.dart';
import 'package:closet_craft_project/features/recommendation/provider/recommendation_provider.dart';
import 'package:closet_craft_project/features/weather/provider/weather_provider.dart';
import 'package:closet_craft_project/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider<WeatherProvider>(
        create: (_) => WeatherProvider(),
      ),
      ChangeNotifierProvider<RecommendationProvider>(
        create: (_) => RecommendationProvider(),
      ),
      ChangeNotifierProvider<ClosetProvider>(
        create: (_) => ClosetProvider(),
      ),
    ], child: const MyApp()),
  );
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
