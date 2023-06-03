part of 'weekly_weather_bloc.dart';

abstract class WeeklyWeatherEvent extends Equatable {
  List<Object> get props => [];
  const WeeklyWeatherEvent();
}

class FetchWeeklyWeatherEvent extends WeeklyWeatherEvent{
  final String cityName;
  FetchWeeklyWeatherEvent({required this.cityName});
}
