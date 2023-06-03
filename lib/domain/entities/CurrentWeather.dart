import '../../data/models/ConditionModel.dart';

class CurrentWeather{
  final String? name;
  final String? region;
  final String? country;
  final double? tempC;
  final ConditionModel? condition;
  final double? windKph;
  final double? feelslikeC;
  final double? uv;
  final String? date;

  CurrentWeather(this.name, this.region, this.country, this.tempC, this
      .condition, this.windKph, this.feelslikeC, this.uv, this.date);
}
