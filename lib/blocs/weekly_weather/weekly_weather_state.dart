part of 'weekly_weather_bloc.dart';

abstract class WeeklyWeatherState extends Equatable {
  List<Object> get props => [];
  const WeeklyWeatherState();
}

class WeeklyWeatherInitialState extends WeeklyWeatherState {}

class WeeklyWeatherLoadingState extends WeeklyWeatherState {}

class WeeklyWeatherLoadedState extends WeeklyWeatherState {
  final List<DayWeatherWithDate> weeklyWeathers;
  const WeeklyWeatherLoadedState({required this.weeklyWeathers});
}

class WeeklyWeatherErrorState extends WeeklyWeatherState {}
