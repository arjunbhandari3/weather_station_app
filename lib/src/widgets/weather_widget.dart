import 'package:flutter/material.dart';
import 'package:weather_station/src/widgets/appContainer.dart';
import 'package:weather_station/src/model/weather.dart';
import 'package:weather_station/src/widgets/forecast_horizontal_widget.dart';
import 'package:weather_station/src/widgets/weather_value_tile.dart';
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
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              this.weather.cityName.toUpperCase(),
                              style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: 5,
                                  color: Colors.black,
                                  fontSize: 25),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              DateFormat('EEEE, d MMMM yyyy')
                                  .format(DateTime.now()),
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              this.weather.description.toUpperCase(),
                              style: TextStyle(
                                fontWeight: FontWeight.w300,
                                letterSpacing: 5,
                                fontSize: 15,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Icon(
                              weather.getIconData(),
                              color: Colors.black,
                              size: 40,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              '${this.weather.temperature.as(AppStateContainer.of(context).temperatureUnit).round()}°',
                              style: TextStyle(
                                fontSize: 70,
                                fontWeight: FontWeight.w200,
                                color: Colors.black,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                ValueTile(
                                    "Sunrise",
                                    DateFormat('h:mm a').format(
                                        DateTime.fromMillisecondsSinceEpoch(
                                            this.weather.sunrise * 1000))),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20),
                                  child: Center(
                                      child: Container(
                                    width: 1,
                                    height: 30,
                                    color: Colors.black.withAlpha(50),
                                  )),
                                ),
                                ValueTile(
                                  "Sunset",
                                  DateFormat('h:mm a').format(
                                    DateTime.fromMillisecondsSinceEpoch(
                                        this.weather.sunset * 1000),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              child: Divider(
                                color: Colors.black.withAlpha(50),
                              ),
                              padding: EdgeInsets.all(10),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                ValueTile(
                                    "Pressure", '${this.weather.pressure} hPa'),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20),
                                  child: Center(
                                      child: Container(
                                    width: 1,
                                    height: 30,
                                    color: Colors.black.withAlpha(90),
                                  )),
                                ),
                                ValueTile(
                                    "Humidity", '${this.weather.humidity}%'),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20),
                                  child: Center(
                                      child: Container(
                                    width: 1,
                                    height: 30,
                                    color: Colors.black.withAlpha(50),
                                  )),
                                ),
                                ValueTile("Wind Speed",
                                    '${this.weather.windSpeed} m/s'),
                              ],
                            ),
                            Padding(
                              child: Divider(
                                color: Colors.black.withAlpha(50),
                              ),
                              padding: EdgeInsets.all(10),
                            ),
                            ForecastHorizontal(weathers: weather.forecast),
                            Padding(
                              child: Divider(
                                color: Colors.black.withAlpha(50),
                              ),
                              padding: EdgeInsets.all(10),
                            ),
                          ],
                        ),
                      ),
                    ],
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
