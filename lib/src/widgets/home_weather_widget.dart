import 'package:flutter/material.dart';
import 'package:weather_station/src/widgets/appContainer.dart';
import 'package:weather_station/src/model/weather.dart';
import 'package:weather_station/src/widgets/value_tile.dart';
import 'package:intl/intl.dart';

class WeatherWidget extends StatelessWidget {
  final Weather weather;
  WeatherWidget({this.weather}) : assert(weather != null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Container(
              child: Column(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5.0)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    this.weather.cityName.toUpperCase(),
                                    style: TextStyle(
                                      fontWeight: FontWeight.w900,
                                      letterSpacing: 5,
                                      color: Colors.black,
                                      fontSize: 32,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    DateFormat('EEEE, d MMMM yyyy')
                                        .format(DateTime.now()),
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 17,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    this.weather.description.toUpperCase(),
                                    style: TextStyle(
                                      fontWeight: FontWeight.w300,
                                      letterSpacing: 5,
                                      fontSize: 18,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Icon(
                                    weather.getIconData(),
                                    color: Colors.black,
                                    size: 50,
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    '${this.weather.temperature.as(AppStateContainer.of(context).temperatureUnit).round()}°',
                                    style: TextStyle(
                                      fontSize: 100,
                                      fontWeight: FontWeight.w100,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Padding(
                                    child: Divider(
                                      color: Colors.white,
                                    ),
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5.0),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Container(
                      padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          ValueTile("Pressure", '${this.weather.pressure} hPa'),
                          Padding(
                            padding: const EdgeInsets.only(left: 15, right: 15),
                            child: Center(
                              child: Container(
                                width: 1,
                                height: 50,
                                color: Colors.black.withAlpha(50),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          ValueTile("Humidity", '${this.weather.humidity}%'),
                          Padding(
                            padding: const EdgeInsets.only(left: 15, right: 15),
                            child: Center(
                              child: Container(
                                width: 1,
                                height: 50,
                                color: Colors.black.withAlpha(50),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          ValueTile(
                              "Wind Speed", '${this.weather.windSpeed} m/s'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
