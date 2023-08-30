import 'dart:convert';
import 'package:http/http.dart';
import 'weather.dart';

class WeatherRepository {

  static const String _apiKey = 'cd1cb42915030edc9876ef0c5d10b3fc';
  static const String _baseUrl = 'https://api.openweathermap.org/data/2.5/weather';

  static Future<Weather> getWeather(String city) async {

    final response = await get(
      Uri.parse('${_baseUrl}?q=${city}&appid=${_apiKey}&units=metric'),
    );

    if (response.statusCode == 200 || response.statusCode ==201) {
      final weatherData = jsonDecode(response.body);
      return Weather.fromJson(weatherData);
    } else {
      throw Exception('Failed to get weather');
    }
  }
}

