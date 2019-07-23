import 'package:equatable/equatable.dart';

abstract class WeatherEvent extends Equatable {
  WeatherEvent([List props = const []]) : super(props);
}

class FetchWeather extends WeatherEvent {
  final String cityName;

  FetchWeather({this.cityName})
      : assert(cityName != null),
        super([cityName]);
}
