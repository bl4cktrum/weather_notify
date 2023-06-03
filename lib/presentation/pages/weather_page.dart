import 'package:flutter/material.dart';
import 'package:weather_notify/presentation/widgets/DailyVisual.dart';
import 'package:weather_notify/presentation/widgets/Section.dart';

import '../widgets/HourlyWeathers.dart';
import '../widgets/WeeklyWeather.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsetsDirectional.fromSTEB(0, 22, 0, 12),
      child: Column(
        children: [
          Section(
              flex: 3,
              child: Column(children: [
                Section(
                    flex: 5,
                    child: DailyVisual()),
                Section(
                    flex: 3,
                    child: HourlyWeathers()),
              ])
          ),
          Section(
              flex: 4,
              child: WeeklyWeather()
          )
        ],
      ),
    );
  }
}
