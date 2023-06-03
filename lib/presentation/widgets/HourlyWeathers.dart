import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weather_notify/blocs/hourly_weather/hourly_weather_bloc.dart';
import 'package:weather_notify/domain/entities/HourDetail.dart';
import 'package:weather_notify/injection.dart';

class HourlyWeathers extends StatelessWidget {
  const HourlyWeathers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _hourlyWeatherBloc = locator<HourlyWeatherBloc>();
    return Container(
      child: BlocBuilder(
        bloc: _hourlyWeatherBloc,
        builder: (context, HourlyWeatherState state) {
          if (state is HourlyWeatherLoadingState) {
            return Container(
                alignment: Alignment.center,
                child: CircularProgressIndicator(color: Colors.black));
          }
          else if (state is HourlyWeatherLoadedState) {
            List<HourDetail> _hourDetails = state.hourlyWeathers;
            return ListView.builder(
                shrinkWrap: true,
                itemCount: _hourDetails.length,
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.all(8),
                itemBuilder: (context, index) {
                  HourDetail hour = _hourDetails.elementAt(index);
                  return Card(
                    child: Container(
                      width: 60,
                      height: 60,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(DateFormat.Hm()
                              .format(DateTime.parse(hour.time))),
                          Image.network('https:${hour.icon}', width: 24),
                          Text(hour.tempC.toString()),
                        ],
                      ),
                    ),
                  );
                });
          }
          else if (state is HourlyWeatherErrorState) {
            return const Center(
              child: Text('Fetch failed!'),
            );
          }
          else {
            return const Text("No widget to build");
          }
        },
      ),
    );
  }
}
