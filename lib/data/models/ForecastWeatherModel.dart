import 'package:weather_notify/data/models/CurrentModel.dart';
import 'package:weather_notify/data/models/ForecastModel.dart';
import 'package:weather_notify/data/models/LocationModel.dart';

class ForecastWeatherModel {
  LocationModel? location;
  CurrentModel? current;
  ForecastModel? forecast;

  ForecastWeatherModel({this.location, this.current, this.forecast});

  ForecastWeatherModel.fromJson(Map<String, dynamic> json) {
    location = json['location'] != null
        ? new LocationModel.fromJson(json['location'])
        : null;
    current =
    json['current'] != null ? new CurrentModel.fromJson(json['current']) : null;
    forecast = json['forecast'] != null
        ? new ForecastModel.fromJson(json['forecast'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.location != null) {
      data['location'] = this.location!.toJson();
    }
    if (this.current != null) {
      data['current'] = this.current!.toJson();
    }
    if (this.forecast != null) {
      data['forecast'] = this.forecast!.toJson();
    }
    return data;
  }
}

