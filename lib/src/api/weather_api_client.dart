import 'dart:convert';
import 'package:weather_station/src/api/http_exception.dart';
import 'package:weather_station/src/model/weather.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

class WeatherApiClient {
  static const baseUrl = 'http://api.openweathermap.org';
  final apiKey;
  final http.Client httpClient;

  WeatherApiClient({@required this.httpClient, this.apiKey})
      : assert(httpClient != null);

  Future<Weather> getWeatherData(String cityName) async {
    final url = '$baseUrl/data/2.5/weather?q=$cityName&appid=$apiKey';
    print('fetching $url');
    final res = await this.httpClient.get(url);
    if (res.statusCode != 200) {
      throw HTTPException(res.statusCode, "unable to fetch weather data");
    }
    final weatherJson = json.decode(res.body);
    return Weather.fromJson(weatherJson);
  }

  Future<List<Weather>> getForecast(String cityName) async {
    final url = '$baseUrl/data/2.5/forecast?q=$cityName&appid=$apiKey';
    print('fetching $url');
    final res = await this.httpClient.get(url);
    if (res.statusCode != 200) {
      throw HTTPException(res.statusCode, "unable to fetch weather data");
    }
    final forecastJson = json.decode(res.body);
    List<Weather> weathers = Weather.fromForecastJson(forecastJson);
    return weathers;
  }
}

Future<Weather> fetchWeather() async {
  final response = await http.get('http://www.weatherku.herokuapp.com/api');

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON.
    return Weather.fromJson(json.decode(response.body));
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}
