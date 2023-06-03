import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_notify/data/repositories/WeatherRepository.dart';
import 'package:weather_notify/domain/entities/DayWeatherWithDate.dart';

import '../../injection.dart';

class WeeklyWeather extends StatefulWidget {
  const WeeklyWeather({Key? key}) : super(key: key);

  @override
  State<WeeklyWeather> createState() => _WeeklyWeatherState();
}

class _WeeklyWeatherState extends State<WeeklyWeather> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(0, 8, 0, 10),
      child: Column( children: [
        Container(
          margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Card(
            elevation: 12,
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 6),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: const ListTile(
              title: Text("Weekly Reports",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
              trailing: Text("Eskisehir",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20)
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: FutureBuilder<List<DayWeatherWithDate>>(
              future: locator<WeatherRepository>().getForecastDays('eskisehir'),
              builder: (context, snapshot) {
                if(snapshot.hasData){
                  List<DayWeatherWithDate> _dayList = snapshot.data!;
                  return ListView.builder(shrinkWrap: true,itemCount: _dayList
                      .length,
                  padding: EdgeInsets.symmetric(vertical: 0),
                  itemBuilder: (context, index) {
                    DayWeatherWithDate day = _dayList[index];
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      elevation: 6,
                      child: ListTile(
                        leading: Image.network('https:${day.dayWeather!
                            .condition!.icon!}',
                            width: 24),
                        title: Text('${day.dayWeather!.avgtempC
                            .toString()}°C'),
                        subtitle: Text(day.dayWeather!.condition!.text
                            .toString()),
                        trailing: Text(DateFormat('EEEE').format
                          (DateTime.parse(day.date!))),
                        visualDensity: VisualDensity(vertical: -4),
                      ),
                    );
                  });
                }
                else if (snapshot.hasError){
                  return Center(child: Text('Fetch failed!'),);
                }
                else {
                  return Container(
                    alignment: Alignment.center,
                      child: CircularProgressIndicator(color: Colors.black));
                }
              },
            ),
          ),
        )
      ]),
    );
  }
}
