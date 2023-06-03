part of 'weather_bloc.dart';

abstract class WeatherState extends Equatable {
  List<Object> get props => [];
  const WeatherState();
}

class CurrentWeatherInitialState extends WeatherState {}

class CurrentWeatherLoadingState extends WeatherState {}

class CurrentWeatherLoadedState extends WeatherState {
  final CurrentWeather currentWeather;
  const CurrentWeatherLoadedState({required this.currentWeather});
}

class CurrentWeatherErrorState extends WeatherState {}
