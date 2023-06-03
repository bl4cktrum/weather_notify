import 'package:weather_notify/data/models/LocationModel.dart';

import '../../domain/entities/CurrentWeather.dart';
import 'CurrentModel.dart';

class CurrentWeatherModel {
  LocationModel? location;
  CurrentModel? current;

  CurrentWeatherModel({this.location, this.current});

  CurrentWeatherModel.fromJson(Map<String, dynamic> json) {
    location = json['location'] != null
        ? LocationModel.fromJson(json['location'])
        : null;
    current =
        json['current'] != null ? CurrentModel.fromJson(json['current']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.location != null) {
      data['location'] = this.location!.toJson();
    }
    if (this.current != null) {
      data['current'] = this.current!.toJson();
    }
    return data;
  }

  CurrentWeather toCurrentWeather(){
    return CurrentWeather(this.location!.name,
        this.location!.region,
        this.location!.country,
        this.current!.tempC,
        this.current!.condition,
        this.current!.windKph,
        this.current!.feelslikeC,
        this.current!.uv,
        this.location!.localtime,
    );
  }
}
