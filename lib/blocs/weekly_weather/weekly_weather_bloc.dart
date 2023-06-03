import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_notify/data/repositories/WeatherRepository.dart';
import 'package:weather_notify/domain/entities/DayWeatherWithDate.dart';
import 'package:weather_notify/injection.dart';

part 'weekly_weather_event.dart';
part 'weekly_weather_state.dart';

class WeeklyWeatherBloc extends Bloc<WeeklyWeatherEvent, WeeklyWeatherState> {
  final WeatherRepository weatherRepository = locator<WeatherRepository>();

  WeeklyWeatherBloc() : super(WeeklyWeatherInitialState()) {
    on<FetchWeeklyWeatherEvent>((event, emit) async {
      emit(WeeklyWeatherLoadingState());
      try {
        List<DayWeatherWithDate> weeklyWeathers = await weatherRepository.getForecastDays(event.cityName);
        emit(WeeklyWeatherLoadedState(weeklyWeathers: weeklyWeathers));
      } catch(e){
        emit(WeeklyWeatherErrorState());
      }
    });
  }
}
