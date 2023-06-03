import 'package:flutter/material.dart';
import 'package:weather_notify/data/models/CurrentWeatherModel.dart';
import 'package:weather_notify/data/repositories/WeatherRepository.dart';
import 'package:weather_notify/injection.dart';
import 'package:weather_notify/presentation/pages/weather_page.dart';

import 'data/constants.dart';

void main() {
  init();
  runApp(WeatherNotifyApp());
}

class WeatherNotifyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          scaffoldBackgroundColor: AppColors.scaffoldBackground
      ),
      home: Scaffold(
        body: const WeatherPage(),
        floatingActionButton: FloatingActionButton(
          onPressed: test,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          child: const Icon(Icons.abc,color: Colors.white, size: 56),
        ),
      ),
    );
  }

  void test() async {
    CurrentWeatherModel currentWeatherModel = await locator.get<WeatherRepository>().getCurrentWeather('eskisehir');
    print(currentWeatherModel.toJson());
  }
}
