import 'package:flutter/material.dart';
import 'package:weather_station/src/screens/home_screen.dart';
import 'package:weather_station/src/screens/settings_screen.dart';
import 'package:weather_station/src/screens/weather_screen.dart';
import 'package:weather_station/src/screens/check_weather.dart';
import 'package:weather_station/src/screens/login.dart';

class Routes {
  static final mainRoute = <String, WidgetBuilder>{
    '/home': (context) => HomeScreen(),
    '/weatherscreen': (context) => WeatherScreen(),
    '/settings': (context) => SettingsScreen(),
    '/checkweather': (context) => SearchWeatherScreen(),
    '/login': (BuildContext context) => LoginPage(),
    // '/signup': (BuildContext context) => new SignUpScreen(),
    // '/signup2': (BuildContext context) => new CompleteSignUpScreen(),
  };
}