import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_notify/data/repositories/WeatherRepository.dart';
import 'package:weather_notify/domain/entities/HourDetail.dart';
import 'package:weather_notify/injection.dart';

import '../../domain/entities/HourlyWeather.dart';

class HourlyWeathers extends StatelessWidget {
  const HourlyWeathers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<HourlyWeather>(
        future: locator<WeatherRepository>()
            .getHourlyWeatherAsViewModel('eskisehir'),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            HourlyWeather _hourlyWeather = snapshot.data!;
            List<HourDetail> _hourDetails = [];
            _hourlyWeather.forecast!.forecastday!.first.hour!.forEach((element) {
              if(DateTime.now().compareTo(DateTime.parse(element.time!)) < 0){
                _hourDetails.add(HourDetail(element.time!, element.condition!
                    .icon!, element.tempC!,
                    element.condition!.code!));
              };
            });
          return ListView.builder(
                shrinkWrap: true,
                itemCount:
                  _hourDetails.length,
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.all(8),
                itemBuilder: (context, index) {
                  HourDetail hour =
                    _hourDetails.elementAt(index);
                  return Card(
                    child: Container(
                      width: 60,
                      height: 60,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(DateFormat.Hm()
                              .format(DateTime.parse(hour.time))),
                          Image.network('https:${hour.icon}',
                              width: 24),
                          Text(hour.tempC.toString()),
                        ],
                      ),
                    ),
                  );
                });
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Fetch failed!'),
            );
          } else {
            return Container(
                alignment: Alignment.center,
                child: CircularProgressIndicator(color: Colors.black));
          }
        },
      ),
    );
  }
}
