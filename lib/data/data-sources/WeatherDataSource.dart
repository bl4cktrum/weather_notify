import 'dart:convert';

import 'package:weather_notify/data/constants.dart';
import 'package:weather_notify/data/models/CurrentWeatherModel.dart';
import 'package:http/http.dart' as http;
import 'package:weather_notify/data/models/ForecastWeatherModel.dart';
import 'package:weather_notify/data/models/HourlyWeatherModel.dart';

class WeatherDataSource {
  final http.Client client;
  WeatherDataSource({required this.client});

  Future<CurrentWeatherModel> getCurrentWeather(String cityName) async {
    var baseUrl = Uris.CURRENT_WEATHER_URL;
    var queryParameters = {
      "key": Token.API_TOKEN,
      "q": cityName,
      "aqi": "no",
    };

    var url = Uri.parse(baseUrl).replace(queryParameters: queryParameters);
    final response = await client.get(url);

    if (response.statusCode == 200) {
      return CurrentWeatherModel.fromJson(json.decode(response.body));
    } else {
      throw Exception("Fetch Failed!");
    }
  }

  Future<ForecastWeatherModel> getForecastWeather(String cityName) async {
    var baseUrl = Uris.FORECAST_WEATHER_URL;
    var queryParameters = {
      "key": Token.API_TOKEN,
      "days": "7",
      "q": cityName,
      "aqi": "no",
    };

    var url = Uri.parse(baseUrl).replace(queryParameters: queryParameters);
    final response = await client.get(url);
    if (response.statusCode == 200) {
      return ForecastWeatherModel.fromJson(json.decode(response.body));
    } else {
      throw Exception("Fetch Failed!");
    }
  }

  Future<HourlyWeatherModel> getHourlyWeather(String cityName) async {
    var baseUrl = Uris.FORECAST_WEATHER_URL;
    var queryParameters = {
      "key": Token.API_TOKEN,
      "days": "1",
      "q": cityName,
      "aqi": "no",
    };

    var url = Uri.parse(baseUrl).replace(queryParameters: queryParameters);
    final response = await client.get(url);
    if (response.statusCode == 200) {
      return HourlyWeatherModel.fromJson(json.decode(response.body));
    } else {
      throw Exception("Fetch Failed!");
    }
  }
}
