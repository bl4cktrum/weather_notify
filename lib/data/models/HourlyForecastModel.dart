import 'package:weather_notify/data/models/HourlyForecastdayModel.dart';

class HourlyForecastModel {
  List<HourlyForecastdayModel>? forecastday;

  HourlyForecastModel({this.forecastday});

  HourlyForecastModel.fromJson(Map<String, dynamic> json) {
    if (json['forecastday'] != null) {
      forecastday = <HourlyForecastdayModel>[];
      json['forecastday'].forEach((v) {
        forecastday!.add(new HourlyForecastdayModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.forecastday != null) {
      data['forecastday'] = this.forecastday!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
