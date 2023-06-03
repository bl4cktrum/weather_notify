import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_notify/data/repositories/WeatherRepository.dart';
import 'package:weather_notify/domain/entities/HourlyWeather.dart';
import 'package:weather_notify/injection.dart';

part 'hourly_weather_event.dart';
part 'hourly_weather_state.dart';

class HourlyWeatherBloc extends Bloc<HourlyWeatherEvent, HourlyWeatherState> {
  final WeatherRepository weatherRepository = locator<WeatherRepository>();

  HourlyWeatherBloc() : super(HourlyWeatherInitialState()) {
    on<FetchHourlyWeatherEvent>((event, emit) async {
      emit(HourlyWeatherLoadingState());
      try {
        HourlyWeather hourlyWeather = await weatherRepository.getHourlyWeatherAsViewModel(event.cityName);
        emit(HourlyWeatherLoadedState(hourlyWeather: hourlyWeather));
      } catch(e){
        emit(HourlyWeatherErrorState());
      }
    });
  }
}
