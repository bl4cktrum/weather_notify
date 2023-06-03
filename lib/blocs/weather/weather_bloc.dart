import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_notify/data/repositories/WeatherRepository.dart';
import 'package:weather_notify/domain/entities/CurrentWeather.dart';
import 'package:weather_notify/injection.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository = locator<WeatherRepository>();

  WeatherBloc() : super(WeatherInitialState()) {
    /*
    on<WeatherEvent>((event, emit) {
      // TO_DO: implement event handler
    });
    */

    on<FetchCurrentWeatherEvent>((event, emit) async {
      emit(WeatherLoadingState());
      try {
        CurrentWeather currentWeather = await weatherRepository.getCurrentWeatherAsViewModel(event.cityName);
        emit(WeatherLoadedState(currentWeather: currentWeather));
      } catch(e){
        emit(WeatherErrorState());
      }
    });
  }
}
