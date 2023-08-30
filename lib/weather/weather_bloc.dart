import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'weather_state_event.dart';
import 'weather_repository.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {

  WeatherBloc(super.initialState) {
    on<WeatherEvent>(handleWeatherEvent);
  }

  Future<FutureOr<void>> handleWeatherEvent(WeatherEvent event, Emitter<WeatherState> emit) async {

    if (event is WeatherRequested) {
      emit(WeatherLoading());
      try {
        // Network Call
        final weather = await WeatherRepository.getWeather(event.city);
        emit(WeatherLoaded(weather));
      } catch (e) {
        emit(WeatherError(e.toString()));
      }

    }
  }
}
