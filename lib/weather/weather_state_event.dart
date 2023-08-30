import 'package:weather_app/weather/weather.dart';

abstract class WeatherEvent {}

class WeatherRequested extends WeatherEvent {
  final String city;
  WeatherRequested(this.city);
}



// Define the WeatherState class
abstract class WeatherState {}

class WeatherInitial extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherLoaded extends WeatherState {

  final Weather weather;
  WeatherLoaded(this.weather);

}

class WeatherError extends WeatherState {
  final String error;

  WeatherError(this.error);
}