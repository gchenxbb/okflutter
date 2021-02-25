import 'package:flutterko/weather/bloc.dart';
import 'package:flutterko/weather/weather_widget.dart';
import 'package:flutterko/weather/weather_apiclient.dart';
import 'package:flutterko/weather/weather_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:http/http.dart' as http;

class WeatherMainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
//    BlocSupervisor.delegate = SimpleBlocDelegate();

    final WeatherRepository weatherRepository = WeatherRepository(
      weatherApiClient: WeatherApiClient(
        httpClient: http.Client(),
      ),
    );

    return MaterialApp(
      title: 'Flutter Weather',
      home: BlocProvider(
        builder: (context) => WeatherBloc(weatherRepository: weatherRepository),
        child: Weather(),
      ),
    );
  }
}
