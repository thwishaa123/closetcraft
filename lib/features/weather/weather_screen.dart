import 'dart:convert';
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
      setState(() => weatherCondition = 'Location Disabled');
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever ||
        permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        setState(() => weatherCondition = 'Permission Denied');
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
      setState(() {
        temperature = data['main']['temp'].round();
        weatherCondition = data['weather'][0]['main'];
        humidity = data['main']['humidity'];
        windSpeed = data['wind']['speed'].round();
        locationName = data['name'];
      });
    } else {
      setState(() => weatherCondition = 'Error fetching data');
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
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("Weather Outfit"),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: fetchWeather,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Weather overview card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    weatherIcons[weatherCondition] ?? Icons.question_mark,
                    size: 32,
                    color: Colors.indigo,
                  ),
                  Text(
                    "$temperature°C",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      const Icon(Icons.location_on, color: Colors.indigo),
                      Text(locationName),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

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
                icon: Icons.water_drop, label: "Humidity", value: "$humidity%"),
            WeatherInfoRow(
                icon: Icons.air, label: "Wind", value: "$windSpeed km/h"),

            const SizedBox(height: 20),

            // Outfit suggestion
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Text(
                _getOutfitSuggestion(),
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ],
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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: Colors.indigo, size: 20),
          const SizedBox(width: 12),
          Text(label),
          const Spacer(),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
