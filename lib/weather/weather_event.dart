import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

@immutable
abstract class WeatherEvent extends Equatable {
  WeatherEvent();
}

class FetchWeather extends WeatherEvent {
  final String city;

  FetchWeather({@required this.city}) : assert(city != null);

  @override
  List<Object> get props => [city];
}
