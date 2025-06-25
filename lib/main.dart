import 'package:closet_craft_project/features/auth/pages/login.dart';
import 'package:closet_craft_project/features/bottom_navigation/bottom_navigation.dart';
import 'package:closet_craft_project/features/calendar/provider/outfit_event_provider.dart';
import 'package:closet_craft_project/features/closet/provider/closet_provider.dart';
import 'package:closet_craft_project/features/onboarding/onboarding_page.dart';
import 'package:closet_craft_project/features/profile/provider/profile_provider.dart';
import 'package:closet_craft_project/features/recommendation/provider/recommendation_provider.dart';
import 'package:closet_craft_project/features/weather/provider/weather_provider.dart';
import 'package:closet_craft_project/firebase_options.dart';
import 'package:closet_craft_project/theme/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
      ChangeNotifierProvider<OutfitEventProvider>(
        create: (_) => OutfitEventProvider()..getOutfitEvent(),
      ),
      ChangeNotifierProvider<ProfileProvider>(
        create: (_) => ProfileProvider()..getProfileDetails(),
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
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: const AppBarTheme(
          backgroundColor: appBarBackground,
          foregroundColor: appBarForeground,
        ),
      ),
      home: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data != null) {
              return const HomeScreen();
            }
            return const OnboardingPage();
          }), // first page when app opens
    );
  }
}
