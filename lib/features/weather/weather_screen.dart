import 'dart:convert';
import 'package:closet_craft_project/features/weather/suggest_outfit_widget.dart';
import 'package:closet_craft_project/utils/responsive_utils.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  int temperature = 0;
  String weatherCondition = 'Loading...';
  int humidity = 0;
  int windSpeed = 0;
  String locationName = 'Fetching...';
  String? weatherData;

  final Map<String, IconData> weatherIcons = {
    'Clear': Icons.wb_sunny,
    'Clouds': Icons.cloud,
    'Rain': Icons.water_drop,
    'Snow': Icons.ac_unit,
    'Thunderstorm': Icons.thunderstorm,
    'Drizzle': Icons.grain,
    'Mist': Icons.blur_on,
    'Fog': Icons.cloud_queue,
  };

  @override
  void initState() {
    super.initState();
    fetchWeather();
  }

  Future<void> fetchWeather() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.requestPermission();
      // setState(() => weatherCondition = 'Location Disabled');
      // return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever ||
        permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        if (mounted) setState(() => weatherCondition = 'Permission Denied');
        return;
      }
    }

    Position position = await Geolocator.getCurrentPosition();
    final lat = position.latitude;
    final lon = position.longitude;

    const apiKey = '7f61f1c1041e2e6fa47202ecf02ee646';
    final url =
        'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&units=metric&appid=$apiKey';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (mounted) {
        setState(() {
          temperature = data['main']['temp'].round();
          weatherCondition = data['weather'][0]['main'];
          humidity = data['main']['humidity'];
          windSpeed = data['wind']['speed'].round();
          locationName = data['name'];
          weatherData =
              "Weather of my loaction $temperature $weatherCondition $humidity $windSpeed";
        });
      }
    } else {
      if (mounted) setState(() => weatherCondition = 'Error fetching data');
    }
  }

  String _getOutfitSuggestion() {
    if (weatherCondition == 'Rain') {
      return "It's raining in $locationName! Wear a waterproof jacket and carry an umbrella.";
    } else if (weatherCondition == 'Snow') {
      return "Snowy in $locationName! Wear a heavy coat, boots, and scarf.";
    } else if (temperature >= 30) {
      return "Hot day in $locationName! Light cotton clothes are best.";
    } else if (temperature >= 20) {
      return "Nice weather in $locationName. T-shirt and jeans would be fine.";
    } else if (temperature >= 10) {
      return "Cool in $locationName. Wear a jacket or sweater.";
    } else {
      return "Cold in $locationName! Bundle up with warm clothes.";
    }
  }

  @override
  Widget build(BuildContext context) {
    final isIPhoneProMax = context.isIPhoneProMax;
    final isTabletOrLarger = context.isTabletOrLarger;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(
          "Weather Outfit",
          style: context.responsiveTextStyle(
            fontSize: isIPhoneProMax ? 22 : 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        toolbarHeight: context.responsiveAppBarHeight,
        actions: [
          IconButton(
            icon: Icon(
              Icons.refresh,
              size: context.responsiveIconSize(24),
            ),
            onPressed: fetchWeather,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: context.responsivePadding,
          child: Column(
            children: [
              // Weather overview card
              Container(
                width: double.infinity,
                padding: context.responsiveCardPadding,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.circular(context.responsiveSpacing(16)),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      weatherIcons[weatherCondition] ?? Icons.cloud,
                      size: context.responsiveIconSize(32),
                      color: Colors.indigo,
                    ),
                    Text(
                      "$temperature°C",
                      style: context.responsiveTextStyle(
                        fontSize:
                            isIPhoneProMax ? 22 : (isTabletOrLarger ? 20 : 18),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: Colors.indigo,
                          size: context.responsiveIconSize(20),
                        ),
                        SizedBox(width: context.responsiveSpacing(4)),
                        Text(
                          locationName,
                          style: context.responsiveTextStyle(
                            fontSize: isIPhoneProMax ? 16 : 14,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: context.responsiveSpacing(20)),

              // Weather details
              WeatherInfoRow(
                  icon: Icons.thermostat,
                  label: "Temperature",
                  value: "$temperature°C"),
              WeatherInfoRow(
                  icon: weatherIcons[weatherCondition] ?? Icons.question_mark,
                  label: "Condition",
                  value: weatherCondition),
              WeatherInfoRow(
                  icon: Icons.water_drop,
                  label: "Humidity",
                  value: "$humidity%"),
              WeatherInfoRow(
                  icon: Icons.air, label: "Wind", value: "$windSpeed km/h"),

              SizedBox(height: context.responsiveSpacing(20)),

              // Outfit suggestion
              Container(
                width: double.infinity,
                padding: context.responsiveCardPadding,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.circular(context.responsiveSpacing(16)),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Text(
                  _getOutfitSuggestion(),
                  style: context.responsiveTextStyle(
                    fontSize:
                        isIPhoneProMax ? 18 : (isTabletOrLarger ? 17 : 16),
                  ),
                ),
              ),

              SizedBox(height: context.responsiveSpacing(20)),

              FashionCard(
                weatherData: weatherData,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class WeatherInfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const WeatherInfoRow({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final isIPhoneProMax = context.isIPhoneProMax;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: context.responsiveSpacing(8)),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.indigo,
            size: context.responsiveIconSize(20),
          ),
          SizedBox(width: context.responsiveSpacing(12)),
          Text(
            label,
            style: context.responsiveTextStyle(
              fontSize: isIPhoneProMax ? 16 : 14,
            ),
          ),
          const Spacer(),
          Text(
            value,
            style: context.responsiveTextStyle(
              fontSize: isIPhoneProMax ? 16 : 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
