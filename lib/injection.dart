import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';
import 'package:weather_notify/blocs/current_weather/weather_bloc.dart';
import 'package:weather_notify/blocs/hourly_weather/hourly_weather_bloc.dart';
import 'package:weather_notify/blocs/weekly_weather/weekly_weather_bloc.dart';
import 'package:weather_notify/data/data-sources/WeatherDataSource.dart';
import 'package:weather_notify/data/repositories/WeatherRepository.dart';

final locator = GetIt.instance;

void injectionContainerInit() {
  // Must be before datasource
  locator.registerLazySingleton(() => http.Client());

// Must be after http client
  locator.registerLazySingleton(() => WeatherDataSource(client: locator()));

  // Must be after datasource
  locator.registerLazySingleton(
    () => WeatherRepository(
      weatherDataSource: locator(),
    ),
  );

  locator.registerLazySingleton(() => WeeklyWeatherBloc());
  locator.registerLazySingleton(() => HourlyWeatherBloc());
  locator.registerLazySingleton(() => WeatherBloc());
}
