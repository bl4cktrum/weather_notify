part of 'hourly_weather_bloc.dart';

abstract class HourlyWeatherState extends Equatable {
  List<Object> get props => [];
  const HourlyWeatherState();
}

class HourlyWeatherInitialState extends HourlyWeatherState {}

class HourlyWeatherLoadingState extends HourlyWeatherState {}

class HourlyWeatherLoadedState extends HourlyWeatherState {
  final HourlyWeather hourlyWeather;
  const HourlyWeatherLoadedState({required this.hourlyWeather});
}

class HourlyWeatherErrorState extends HourlyWeatherState {}
