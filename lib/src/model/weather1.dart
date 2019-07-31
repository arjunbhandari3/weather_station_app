import 'package:weather_station/src/utils/converters.dart';

class Weather {
  final Temperature temperature;
  final int pressure;
  final int humidity;
  final int altitude;

  Weather({this.temperature, this.pressure, this.humidity, this.altitude});

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      temperature: json['temperature'],
      pressure: json['pressure'],
      humidity: json['humidity'],
      altitude: json['altitude'],
    );
  }
}
