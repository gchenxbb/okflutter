import 'package:flutterchannel/weather/lastupdated.dart';
import 'package:flutterchannel/weather/location.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterchannel/weather/bloc.dart';

class Weather extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Weather'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              final city = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Container(
                    child: Text('select'),
                    color: Colors.white,
                  ),
//                  builder: (context) => CitySelection(),
                ),
              );
              if (city != null) {
                BlocProvider.of<WeatherBloc>(context)
                    .dispatch(FetchWeather(city: city));
              }
            },
          )
        ],
      ),
      body: Center(
        child: BlocBuilder<WeatherEvent, WeatherState>(
          bloc: BlocProvider.of<WeatherBloc>(context),
          builder: (context, state) {
            if (state is InitialWeatherState) {
              return Center(child: Text('Please Select a Location'));
            }
            if (state is WeatherLoading) {
              return Center(child: CircularProgressIndicator());
            }
            if (state is WeatherLoaded) {
              final weather = state.weather;

              return ListView(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 100.0),
                    child: Center(
                      child: Location(location: weather.location),
                    ),
                  ),
                  Center(
                    child: LastUpdated(dateTime: weather.lastUpdated),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 50.0),
                    child: Center(
                      child: Container(),
//                      child: CombinedWeatherTemperature(
//                        weather: weather,
//                      ),
                    ),
                  ),
                ],
              );
            }
            if (state is WeatherError) {
              return Text(
                'Something went wrong!',
                style: TextStyle(color: Colors.red),
              );
            }
            return Center(child: Text('Nill'));
          },
        ),
      ),
    );
  }
}
