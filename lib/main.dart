import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_notify/blocs/current_weather/weather_bloc.dart';
import 'package:weather_notify/blocs/hourly_weather/hourly_weather_bloc.dart';
import 'package:weather_notify/blocs/weekly_weather/weekly_weather_bloc.dart';
import 'package:weather_notify/injection.dart';
import 'package:weather_notify/presentation/pages/weather_page.dart';

import 'data/constants.dart';

Future<void> main() async {
  injectionContainerInit();
  runApp(WeatherNotifyApp());
}

class WeatherNotifyApp extends StatefulWidget {
  @override
  State<WeatherNotifyApp> createState() => _WeatherNotifyAppState();
}

class _WeatherNotifyAppState extends State<WeatherNotifyApp> {
  late SharedPreferences preferences;
  bool isCitySetted = false;

  @override
  void initState() {
    super.initState();
    runOnStart();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather Notify',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          scaffoldBackgroundColor: AppColors.scaffoldBackground,
          primarySwatch: Colors.blue),
      home: Scaffold(
        body: isCitySetted
            ? MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (context) => WeatherBloc(),
                  ),
                  BlocProvider(
                    create: (context) => HourlyWeatherBloc(),
                  ),
                  BlocProvider(
                    create: (context) => WeeklyWeatherBloc(),
                  ),
                ],
                child: WeatherPage(),
              )
            : Container(
                alignment: Alignment.center,
                child: CircularProgressIndicator(color: Colors.black)),
      ),
    );
  }

  void runOnStart() {
    SharedPreferences.getInstance().then((sp) async {
      preferences = sp;
      bool isFirstTime = preferences.getBool('isFirstTime') ?? true;
      if (isFirstTime) {
        locator<WeatherBloc>()
            .add(FetchCurrentWeatherEvent(cityName: 'eskisehir'));
        locator<WeeklyWeatherBloc>()
            .add(FetchWeeklyWeatherEvent(cityName: 'eskisehir'));
        locator<HourlyWeatherBloc>()
            .add(FetchHourlyWeatherEvent(cityName: 'eskisehir'));
        setState(() {
          isCitySetted = true;
        });
        preferences.setString('city', 'eskisehir');
        preferences.setBool('isFirstTime', false);
      } else {
        locator<WeatherBloc>().add(
            FetchCurrentWeatherEvent(cityName: preferences.getString('city')!));
        locator<WeeklyWeatherBloc>().add(
            FetchWeeklyWeatherEvent(cityName: preferences.getString('city')!));
        locator<HourlyWeatherBloc>().add(
            FetchHourlyWeatherEvent(cityName: preferences.getString('city')!));
        setState(() {
          isCitySetted = true;
        });
      }
    });
  }
}
