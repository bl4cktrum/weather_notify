import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_notify/blocs/current_weather/weather_bloc.dart';
import 'package:weather_notify/blocs/hourly_weather/hourly_weather_bloc.dart';
import 'package:weather_notify/data/models/CurrentWeatherModel.dart';
import 'package:weather_notify/data/repositories/WeatherRepository.dart';
import 'package:weather_notify/injection.dart';
import 'package:weather_notify/presentation/pages/weather_page.dart';

import 'data/constants.dart';

void main() {
  injectionContainerInit();
  runApp(WeatherNotifyApp());
}

class WeatherNotifyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather Notify',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          scaffoldBackgroundColor: AppColors.scaffoldBackground,
          primarySwatch: Colors.blue
      ),
      home: Scaffold(
        body: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => WeatherBloc(),
            ),
            BlocProvider(
              create: (context) => HourlyWeatherBloc(),
            ),
          ],
          child: WeatherPage(),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: test,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          child: const Icon(Icons.abc, color: Colors.white, size: 56),
        ),
      ),
    );
  }

  void test() async {
    CurrentWeatherModel currentWeatherModel =
    await locator.get<WeatherRepository>().getCurrentWeather('eskisehir');
    print(currentWeatherModel.toJson());
  }
}
