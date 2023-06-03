part of 'weather_bloc.dart';

abstract class WeatherEvent extends Equatable {
  List<Object> get props => [];
  const WeatherEvent();
}

class FetchCurrentWeatherEvent extends WeatherEvent{
  final String cityName;
  FetchCurrentWeatherEvent({required this.cityName});
}
