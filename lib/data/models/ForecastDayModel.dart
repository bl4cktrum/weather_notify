import 'package:weather_notify/data/models/DayModel.dart';

class ForecastDayModel {
  String? date;
  int? dateEpoch;
  DayModel? day;

  ForecastDayModel({this.date, this.dateEpoch, this.day});

  ForecastDayModel.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    dateEpoch = json['date_epoch'];
    day = json['day'] != null ? new DayModel.fromJson(json['day']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['date_epoch'] = this.dateEpoch;
    if (this.day != null) {
      data['day'] = this.day!.toJson();
    }
    return data;
  }
}
