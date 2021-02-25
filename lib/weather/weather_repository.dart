import 'dart:async';
import 'package:flutterko/weather/weather.dart';
import 'package:meta/meta.dart';
import 'package:flutterko/weather/weather_apiclient.dart';

class WeatherRepository {
  final WeatherApiClient weatherApiClient;

  WeatherRepository({@required this.weatherApiClient})
      : assert(weatherApiClient != null);

  Future<Weather> getWeather(String city) async {
    final int locationId = await weatherApiClient.getLocationId(city);
    return await weatherApiClient.fetchWeather(locationId);
  }
}