import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weather_notify/blocs/weekly_weather/weekly_weather_bloc.dart';
import 'package:weather_notify/domain/entities/DayWeatherWithDate.dart';

class WeeklyWeather extends StatelessWidget {
  const WeeklyWeather({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _weeklyWeatherBloc = BlocProvider.of<WeeklyWeatherBloc>(context);
    _weeklyWeatherBloc.add(FetchWeeklyWeatherEvent(cityName: 'eskisehir'));

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
            child: BlocBuilder(
              bloc: _weeklyWeatherBloc,
              builder: (context, WeeklyWeatherState state) {
                if (state is WeeklyWeatherLoadingState){
                  return Container(
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(color: Colors.black));
                }
                else if(state is WeeklyWeatherLoadedState){
                  List<DayWeatherWithDate> _dayList = state.weeklyWeathers;
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
                else if (state is WeeklyWeatherErrorState){
                  return Center(child: Text('Fetch failed!'),);
                }
                else {
                  return const Text("No widget to build");
                }
              },
            ),
          ),
        )
      ]),
    );
  }
}
