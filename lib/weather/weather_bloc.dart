import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutterchannel/weather/weather.dart';
import 'package:flutterchannel/weather/weather_repository.dart';
import 'package:flutter/cupertino.dart';
import './bloc.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {

  final WeatherRepository weatherRepository;

  WeatherBloc({@required this.weatherRepository})
      : assert(weatherRepository != null);

  @override
  WeatherState get initialState => InitialWeatherState();

  @override
  Stream<WeatherState> mapEventToState(
    WeatherEvent event,
  ) async* {
    if (event is FetchWeather) {
      yield WeatherLoading();
      try {
        final Weather weather = await weatherRepository.getWeather(event.city);
        yield WeatherLoaded(weather: weather);
      } catch (_) {
        yield WeatherError();
      }
    }
  }


}
