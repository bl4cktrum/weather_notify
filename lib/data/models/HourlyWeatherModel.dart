import 'package:weather_notify/data/models/HourlyForecastModel.dart';
import 'package:weather_notify/domain/entities/HourlyWeather.dart';

class HourlyWeatherModel {
  HourlyForecastModel? forecast;

  HourlyWeatherModel({this.forecast});

  HourlyWeatherModel.fromJson(Map<String, dynamic> json) {
    forecast = json['forecast'] != null
        ? HourlyForecastModel.fromJson(json['forecast'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.forecast != null) {
      data['forecast'] = this.forecast!.toJson();
    }
    return data;
  }

  HourlyWeather toHourlyWeather(){
    return HourlyWeather(this.forecast);
  }
}


