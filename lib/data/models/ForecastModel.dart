import 'package:weather_notify/data/models/ForecastDayModel.dart';

class ForecastModel {
  List<ForecastDayModel>? forecastday;

  ForecastModel({this.forecastday});

  ForecastModel.fromJson(Map<String, dynamic> json) {
    if (json['forecastday'] != null) {
      forecastday = <ForecastDayModel>[];
      json['forecastday'].forEach((v) {
        forecastday!.add(new ForecastDayModel.fromJson(v));
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
