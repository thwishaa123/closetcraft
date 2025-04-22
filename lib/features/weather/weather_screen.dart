import 'package:closet_craft_project/features/weather/provider/weather_provider.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  int index = 0;

  // Location data with associated weather information
  final Map<String, Map<String, dynamic>> locationData = {
    'New York': {
      'temperature': 25,
      'condition': 'Sunny',
      'humidity': 65,
      'windSpeed': 10,
    },
    'London': {
      'temperature': 18,
      'condition': 'Cloudy',
      'humidity': 78,
      'windSpeed': 15,
    },
    'Tokyo': {
      'temperature': 32,
      'condition': 'Sunny',
      'humidity': 45,
      'windSpeed': 8,
    },
    'Seattle': {
      'temperature': 12,
      'condition': 'Rainy',
      'humidity': 90,
      'windSpeed': 20,
    },
    'Dubai': {
      'temperature': 38,
      'condition': 'Sunny',
      'humidity': 35,
      'windSpeed': 12,
    },
    'Sydney': {
      'temperature': 27,
      'condition': 'Cloudy',
      'humidity': 60,
      'windSpeed': 18,
    },
    'Moscow': {
      'temperature': 5,
      'condition': 'Snowy',
      'humidity': 72,
      'windSpeed': 25,
    },
    'Mumbai': {
      'temperature': 33,
      'condition': 'Rainy',
      'humidity': 85,
      'windSpeed': 8,
    },
  };

  // Current weather variables
  String selectedLocation = 'New York'; // Default location
  int temperature = 25;
  String weatherCondition = 'Sunny';
  int humidity = 65;
  int windSpeed = 10;

  // Weather condition icons mapping
  final Map<String, IconData> weatherIcons = {
    'Sunny': Icons.wb_sunny,
    'Cloudy': Icons.cloud,
    'Rainy': Icons.water_drop,
    'Snowy': Icons.ac_unit,
    'Stormy': Icons.thunderstorm,
    'Foggy': Icons.cloud_queue,
  };

  // late final WeatherProvider weatherProvider;
  // Initialize state
  @override
  void initState() {
    super.initState();
    // weatherProvider = WeatherProvider();
    Future.microtask(
      () => context.read<WeatherProvider>().getCurrentWeather('Delhi'),
    );
    updateWeatherForLocation(selectedLocation);
  }

  // Method to update weather data based on selected location
  void updateWeatherForLocation(String location) {
    if (locationData.containsKey(location)) {
      setState(() {
        selectedLocation = location;
        temperature = locationData[location]!['temperature'];
        weatherCondition = locationData[location]!['condition'];
        humidity = locationData[location]!['humidity'];
        windSpeed = locationData[location]!['windSpeed'];
      });
    }
  }

  Future<LottieComposition?> customDecoder(List<int> bytes) {
    return LottieComposition.decodeZip(bytes, filePicker: (files) {
      return files.firstWhere(
          (f) => f.name.startsWith('animations/') && f.name.endsWith('.json'));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          "Weather Outfit",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          // Add refresh button
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              updateWeatherForLocation(selectedLocation);
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          setState(() {
            index = (index + 1);
            final currentData = locationData[selectedLocation]!;
            temperature = currentData['temperature'] +
                (index % 3 - 1); // -1, 0, or +1 degree change
          });
        },
        label: const Text(
          'Build an Outfit',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      body: Consumer<WeatherProvider>(
        builder: (context, provider, child) {
          print(provider.data == null);
          if (provider.data != null) {
            var data = provider.data!;
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Left Section: Weather icon and temperature
                        Row(
                          children: [
                            Icon(
                              weatherIcons[weatherCondition] ??
                                  Icons.question_mark,
                              color: Colors.indigo,
                              size: 24,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '${data['current']['temp_c']}°C',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[800],
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),

                        // Center Section: Today text
                        Text(
                          '< Today >',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.indigo,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        // Right Section: Location dropdown
                        Row(
                          children: [
                            const Icon(
                              Icons.location_on,
                              color: Colors.indigo,
                              size: 24,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              data['location']['name'],
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[800],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            // DropdownButtonHideUnderline(
                            //   child: DropdownButton<String>(
                            //     value: selectedLocation,
                            //     icon: const Icon(Icons.arrow_drop_down,
                            //         color: Colors.indigo, size: 20),
                            //     style: TextStyle(
                            //       fontSize: 16,
                            //       color: Colors.grey[800],
                            //       fontWeight: FontWeight.w500,
                            //     ),
                            //     onChanged: (String? newValue) {
                            //       if (newValue != null) {
                            //         updateWeatherForLocation(newValue);
                            //       }
                            //     },
                            //     items: locationData.keys
                            //         .map<DropdownMenuItem<String>>(
                            //             (String value) {
                            //       return DropdownMenuItem<String>(
                            //         value: value,
                            //         child: Text(value),
                            //       );
                            //     }).toList(),
                            //   ),
                            // ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Weather details container
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Weather Details",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.indigo,
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Dynamic weather information
                        WeatherInfoRow(
                            icon: Icons.thermostat,
                            label: "Temperature",
                            value: "${data['current']['temp_c']}"),
                        const SizedBox(height: 12),
                        WeatherInfoRow(
                            icon: weatherIcons[weatherCondition] ??
                                Icons.question_mark,
                            label: "Condition",
                            value: weatherCondition),
                        const SizedBox(height: 12),
                        WeatherInfoRow(
                            icon: Icons.water_drop,
                            label: "Humidity",
                            value: "${data['current']['humidity']}%"),
                        const SizedBox(height: 12),
                        WeatherInfoRow(
                            icon: Icons.air, label: "Wind", value: " km/h"),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Outfit suggestion based on weather
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Outfit Suggestion",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.indigo,
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Dynamic outfit suggestion based on weather condition and temperature
                        Text(
                          _getOutfitSuggestion(),
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[800],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Lottie.asset(
              'assets/animation/weather.lottie',
              decoder: customDecoder,
            );
          }
        },
      ),
    );
  }

  // Method to generate outfit suggestions based on current weather
  String _getOutfitSuggestion() {
    if (weatherCondition == 'Rainy') {
      return "It's raining in $selectedLocation! Consider wearing a waterproof jacket, umbrella, and waterproof shoes.";
    } else if (weatherCondition == 'Snowy') {
      return "It's snowing in $selectedLocation! Bundle up with a warm coat, scarf, gloves, and boots.";
    } else if (temperature >= 30) {
      return "It's very hot in $selectedLocation today! Light, breathable fabrics like cotton or linen would be ideal. Don't forget sunscreen!";
    } else if (temperature >= 20) {
      return "Pleasant weather in $selectedLocation today. A light shirt or t-shirt with pants or a skirt would be comfortable.";
    } else if (temperature >= 10) {
      return "It's a bit cool in $selectedLocation today. Consider layering with a light jacket or sweater.";
    } else {
      return "It's cold in $selectedLocation today! Bundle up with a warm coat and layers.";
    }
  }
}

// Helper widget for weather information rows
class WeatherInfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const WeatherInfoRow(
      {super.key,
      required this.icon,
      required this.label,
      required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: Colors.indigo,
          size: 22,
        ),
        const SizedBox(width: 12),
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[600],
          ),
        ),
        const Spacer(),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}
