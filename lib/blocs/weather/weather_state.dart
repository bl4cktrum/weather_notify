part of 'weather_bloc.dart';

abstract class WeatherState extends Equatable {
  List<Object> get props => [];
  const WeatherState();
}

class WeatherInitialState extends WeatherState {}

class WeatherLoadingState extends WeatherState {}

class WeatherLoadedState extends WeatherState {
  final CurrentWeather currentWeather;
  const WeatherLoadedState({required this.currentWeather});
}

class WeatherErrorState extends WeatherState {}
