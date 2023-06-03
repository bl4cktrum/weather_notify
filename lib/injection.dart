import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';
import 'package:weather_notify/data/data-sources/WeatherDataSource.dart';
import 'package:weather_notify/data/repositories/WeatherRepository.dart';

final locator = GetIt.instance;

void init() {
  // Must be first
  locator.registerLazySingleton(() => http.Client());

  // data source
  locator.registerLazySingleton(() => WeatherDataSource(client: locator()));

  // Must be last
  locator.registerLazySingleton(
    () => WeatherRepository(
      weatherDataSource: locator(),
    ),
  );
}
