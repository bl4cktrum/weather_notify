import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:weather_notify/data/repositories/WeatherRepository.dart';
import 'package:weather_notify/domain/entities/CurrentWeather.dart';
import 'package:weather_notify/injection.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository = locator<WeatherRepository>();

  WeatherBloc() : super(CurrentWeatherInitialState()) {
    on<FetchCurrentWeatherEvent>((event, emit) async {
      debugPrint("event");
      emit(CurrentWeatherLoadingState());
      try {
        CurrentWeather currentWeather = await weatherRepository.getCurrentWeatherAsViewModel(event.cityName);
        emit(CurrentWeatherLoadedState(currentWeather: currentWeather));
      } catch(e){
        emit(CurrentWeatherErrorState());
      }
    });
  }
}
