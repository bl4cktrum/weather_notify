import '../../data/models/ConditionModel.dart';

class DayWeather {
  final double? avgtempC;
  final ConditionModel? condition;
  final double? uv;

  DayWeather(this.avgtempC, this.condition, this.uv);
}
