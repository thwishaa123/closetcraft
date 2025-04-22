import 'dart:convert';
import 'dart:developer';

import 'package:closet_craft_project/features/weather/weather_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class WeatherProvider extends ChangeNotifier {
  bool _loading = false;
  bool get loading => _loading;

  String _weatherData = '';
  String _errorMessage = '';
  WeatherModel? _weather;
  WeatherModel? get weather => _weather;

  Map<String, dynamic>? data;

  final String _apiKey = "8ecd4b1a675040a691665432251004";

  String _formatWeatherData(Map<String, dynamic> data) {
    final location = data['location'];
    final current = data['current'];

    return '''
    City: ${location['name']}, ${location['country']}
    Temperature: ${current['temp_c']}°C (${current['temp_f']}°F)
    Condition: ${current['condition']['text']}
    Humidity: ${current['humidity']}%
    Wind Speed: ${current['wind_kph']} km/h (${current['wind_mph']} mph)
    Last Updated: ${current['last_updated']}
    ''';
  }

  Future<void> getCurrentWeather(String city) async {
    _loading = true;
    notifyListeners();

    final String apiUrl =
        'http://api.weatherapi.com/v1/current.json?key=$_apiKey&q=$city&aqi=no';

    try {
      final response = await http.get(Uri.parse(apiUrl));
      log(response.statusCode.toString());
      if (response.statusCode == 200) {
        data = jsonDecode(response.body);
        _weatherData = _formatWeatherData(data!);
        notifyListeners();
      } else {
        final errorData = jsonDecode(response.body);
        _errorMessage =
            errorData['error']['message'] ?? 'Failed to fetch weather data';
        notifyListeners();
      }
    } catch (e) {
      _errorMessage = 'An error occurred: $e';
    } finally {
      _loading = false;
      notifyListeners();
    }
  }
}
