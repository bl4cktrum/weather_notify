import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_notify/blocs/current_weather/weather_bloc.dart';
import 'package:weather_notify/blocs/hourly_weather/hourly_weather_bloc.dart';
import 'package:weather_notify/blocs/weekly_weather/weekly_weather_bloc.dart';
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
                    child: BlocProvider(
                      create: (context) => WeatherBloc(),
                      child: DailyVisual(),
                    )),
                Section(
                    flex: 3,
                    child: BlocProvider(
                      create: (context) => HourlyWeatherBloc(),
                      child: HourlyWeathers(),
                    )),
              ])
          ),
          Section(
              flex: 4,
              child: BlocProvider(
                create: (context) => WeeklyWeatherBloc(),
                child: WeeklyWeather(),
              )
          )
        ],
      ),
    );
  }
}
