part of 'hourly_weather_bloc.dart';

abstract class HourlyWeatherEvent extends Equatable {
  List<Object> get props => [];
  const HourlyWeatherEvent();
}

class FetchHourlyWeatherEvent extends HourlyWeatherEvent{
  final String cityName;
  FetchHourlyWeatherEvent({required this.cityName});
}
