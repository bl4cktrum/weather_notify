import 'package:weather_notify/data/models/HourModel.dart';

class HourlyForecastdayModel {
  List<HourModel>? hour;

  HourlyForecastdayModel({this.hour});

  HourlyForecastdayModel.fromJson(Map<String, dynamic> json) {
    if (json['hour'] != null) {
      hour = <HourModel>[];
      json['hour'].forEach((v) {
        hour!.add(new HourModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.hour != null) {
      data['hour'] = this.hour!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
