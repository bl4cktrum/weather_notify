import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_notify/blocs/current_weather/weather_bloc.dart';
import 'package:weather_notify/data/constants.dart';
import 'package:weather_notify/domain/entities/CurrentWeather.dart';
import 'package:weather_notify/injection.dart';

class DailyVisual extends StatelessWidget {
  const DailyVisual({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _weatherBloc = locator<WeatherBloc>();
    return BlocBuilder(
      bloc: _weatherBloc,
      builder: (context, WeatherState state) {
        if  (state is CurrentWeatherLoadingState){
          return Container(
              alignment: Alignment.center,
              child: CircularProgressIndicator(color: Colors.black));
        }
        else if (state is CurrentWeatherLoadedState) {
          CurrentWeather currentWeather = state.currentWeather;
          return Card(
            color: AppColors.cardColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            margin: EdgeInsets.zero,
            elevation: 6,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                    top: -110,
                    left: -88,
                    child: Image.network(
                      'https:${currentWeather.condition!.icon!.replaceAll('64x64', '128x128')}',
                      fit: BoxFit.cover,
                      isAntiAlias: true,
                      height: 300,
                      width: 300,
                    )),
                Positioned(
                  bottom: 12,
                  left: 24,
                  child: Text(
                    currentWeather.condition!.text!,
                    style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w500),
                  ),
                ),
                Positioned(
                    top: 0,
                    right: 8,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Text(
                            '${currentWeather.tempC!.toString()}',
                            style: const TextStyle(
                              fontSize: 64,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const Text(
                          '°',
                          style: TextStyle(
                            fontSize: 64,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 4),
                          child: Text(
                            'C',
                            style: TextStyle(
                              fontSize: 64,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    )),
                Positioned(
                  right: 12,
                  bottom: 8,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(currentWeather.region!,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          )),
                    ],
                  ),
                )
              ],
            ),
          );
        }
        else if (state is CurrentWeatherErrorState) {
          return const Center(
            child: Text('Fetch failed!'),
          );
        }
        else {
          return const Text("No widget to build");
        }
      },
    );
  }
}
