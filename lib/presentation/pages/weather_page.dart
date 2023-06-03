import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_notify/blocs/current_weather/weather_bloc.dart';
import 'package:weather_notify/blocs/hourly_weather/hourly_weather_bloc.dart';
import 'package:weather_notify/blocs/weekly_weather/weekly_weather_bloc.dart';
import 'package:weather_notify/presentation/widgets/DailyVisual.dart';
import 'package:weather_notify/presentation/widgets/Section.dart';

import '../../injection.dart';
import '../widgets/HourlyWeathers.dart';
import '../widgets/WeeklyWeather.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsetsDirectional.fromSTEB(0, 22, 0, 12),
      child: Stack(
        children: [
          SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: Container(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height
              ),
              child: Column(
                children: [
                  Section(
                      flex: 3,
                      child: Column(children: [
                        Container(
                          child: Section(
                              flex: 5,
                              child: BlocProvider(
                                create: (context) => WeatherBloc(),
                                child: DailyVisual(),
                              )),
                        ),
                        Container(
                          child: Section(
                              flex: 3,
                              child: BlocProvider(
                                create: (context) => HourlyWeatherBloc(),
                                child: HourlyWeathers(),
                              )),
                        ),
                      ])),
                  Section(
                      flex: 4,
                      child: BlocProvider(
                        create: (context) => WeeklyWeatherBloc(),
                        child: WeeklyWeather(),
                      )),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: FloatingActionButton(
              elevation: 6,
              onPressed: () {
                showCityDialog(context);
              },
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              child: const Icon(Icons.search, color: Colors.white, size: 44),
            ),
          )
        ],
      ),
    );
  }

  void showCityDialog(BuildContext context) {
    TextEditingController cityController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Builder(
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Set City'),
              content: TextField(
                controller: cityController,
                decoration: const InputDecoration(hintText: 'Enter city name'),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: const Text('Save'),
                  onPressed: () async {
                    String cityName = cityController.text;
                    locator<WeatherBloc>().add(FetchCurrentWeatherEvent(cityName: cityName));
                    locator<WeeklyWeatherBloc>()
                        .add(FetchWeeklyWeatherEvent(cityName: cityName));
                    locator<HourlyWeatherBloc>()
                        .add(FetchHourlyWeatherEvent(cityName: cityName));

                    (await SharedPreferences.getInstance()).setString('city', cityName);
                    Navigator.of(context).pop(); // Dialog kutusunu kapat
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }
}
