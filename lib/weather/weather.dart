
class Weather {
  final String city;
  final double temperature;
  final String description;

  Weather({required this.city, required this.temperature, required this.description});

  static Future<Weather> fromJson(weatherData) async {
    final Map<String, dynamic> json = weatherData;

    final city = json['name'];
    final temperature = json['main']['temp'];
    final description = json['weather'][0]['description'];

    return Weather(city: city, temperature: temperature, description: description);
  }
}
