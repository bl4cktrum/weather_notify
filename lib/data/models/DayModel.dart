import 'package:weather_notify/data/models/ConditionModel.dart';
import 'package:weather_notify/domain/entities/DayWeather.dart';

class DayModel {
  double? avgtempC;
  ConditionModel? condition;
  double? uv;

  DayModel({this.avgtempC, this.condition, this.uv});

  DayModel.fromJson(Map<String, dynamic> json) {
    avgtempC = json['avgtemp_c'];
    condition = json['condition'] != null
        ? new ConditionModel.fromJson(json['condition'])
        : null;
    uv = json['uv'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['avgtemp_c'] = this.avgtempC;
    if (this.condition != null) {
      data['condition'] = this.condition!.toJson();
    }
    data['uv'] = this.uv;
    return data;
  }

  DayWeather toDayWeather(){
    return DayWeather(this.avgtempC, this.condition, this.uv);
  }
}
