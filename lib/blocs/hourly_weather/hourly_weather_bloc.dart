import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_notify/data/repositories/WeatherRepository.dart';
import 'package:weather_notify/domain/entities/HourDetail.dart';
import 'package:weather_notify/injection.dart';

part 'hourly_weather_event.dart';
part 'hourly_weather_state.dart';

class HourlyWeatherBloc extends Bloc<HourlyWeatherEvent, HourlyWeatherState> {
  final WeatherRepository weatherRepository = locator<WeatherRepository>();

  HourlyWeatherBloc() : super(HourlyWeatherInitialState()) {
    on<FetchHourlyWeatherEvent>((event, emit) async {
      emit(HourlyWeatherLoadingState());
      try {
        List<HourDetail> hourlyWeathers = await weatherRepository.getHourlyWeathersAsViewModel(event.cityName);
        emit(HourlyWeatherLoadedState(hourlyWeathers: hourlyWeathers));
      } catch(e){
        emit(HourlyWeatherErrorState());
      }
    });
  }
}
