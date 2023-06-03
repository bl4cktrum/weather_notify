import 'package:weather_notify/domain/entities/DayWeather.dart';

class DayWeatherWithDate {
  final String? date;
  final DayWeather? dayWeather;

  DayWeatherWithDate(this.date, this.dayWeather);
}
