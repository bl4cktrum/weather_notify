import 'package:weather_notify/data/models/CurrentWeatherModel.dart';
import 'package:weather_notify/data/models/ForecastWeatherModel.dart';
import 'package:weather_notify/data/models/HourlyWeatherModel.dart';
import 'package:weather_notify/domain/entities/DayWeatherWithDate.dart';
import 'package:weather_notify/domain/entities/HourlyWeather.dart';

import '../../domain/entities/CurrentWeather.dart';
import '../data-sources/WeatherDataSource.dart';

class WeatherRepository {
  WeatherDataSource weatherDataSource;

  WeatherRepository({required this.weatherDataSource});

  Future<CurrentWeatherModel> getCurrentWeather(String cityName) async {
    try {
      return await weatherDataSource.getCurrentWeather(cityName);
    } catch (e) {
      throw new Exception("unsuccessfull data fetch!");
    }
  }

  Future<CurrentWeather> getCurrentWeatherAsViewModel(String cityName) async {
    CurrentWeatherModel currentWeatherModel =  await getCurrentWeather(cityName);
    return currentWeatherModel.toCurrentWeather();
  }

  Future<ForecastWeatherModel> getForecastWeather(String cityName) async {
    try {
      return await weatherDataSource.getForecastWeather(cityName);
    } catch (e) {
      throw new Exception("unsuccessfull data fetch!");
    }
  }

  Future<List<DayWeatherWithDate>> getForecastDays(String cityName) async {
    ForecastWeatherModel forecastWeatherModel =
        await getForecastWeather(cityName);
    return forecastWeatherModel.forecast!.forecastday!
        .map((forecastDay) => DayWeatherWithDate(forecastDay.date, forecastDay.day!
        .toDayWeather()))
        .skip(1)
        .toList();
  }

  Future<HourlyWeather> getHourlyWeatherAsViewModel(String cityName) async {
    HourlyWeatherModel hourlyWeatherModel = await getHourlyWeather(cityName);
    return hourlyWeatherModel.toHourlyWeather();
  }

  Future<HourlyWeatherModel> getHourlyWeather(String cityName) async {
    try {
      return await weatherDataSource.getHourlyWeather(cityName);
    } catch (e) {
      throw new Exception('unsuccessfull data fetch! ${e.toString()}');
    }
  }
}
