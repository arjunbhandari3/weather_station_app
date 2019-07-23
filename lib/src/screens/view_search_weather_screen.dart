import 'package:flutter/material.dart';
import 'package:weather_station/src/api/weather_api_client.dart';
import 'package:weather_station/src/bloc/weather_bloc.dart';
import 'package:weather_station/src/bloc/weather_event.dart';
import 'package:weather_station/src/bloc/weather_state.dart';
import 'package:weather_station/src/repository/weather_repository.dart';
import 'package:weather_station/src/api/api_keys.dart';
import 'package:weather_station/src/widgets/weather_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class ViewSearchWeatherScreen extends StatefulWidget {
  final String cityname;
  ViewSearchWeatherScreen(this.cityname);

  final WeatherRepository weatherRepository = WeatherRepository(
      weatherApiClient: WeatherApiClient(
          httpClient: http.Client(), apiKey: ApiKey.OPEN_WEATHER_MAP));
  @override
  _ViewSearchWeatherScreenState createState() =>
      _ViewSearchWeatherScreenState(cityname);
}

class _ViewSearchWeatherScreenState extends State<ViewSearchWeatherScreen>
    with TickerProviderStateMixin {
  WeatherBloc _weatherBloc;

  String cityname;
  _ViewSearchWeatherScreenState(this.cityname);

  AnimationController _fadeController;
  Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _weatherBloc = WeatherBloc(weatherRepository: widget.weatherRepository);
    _fetchWeatherWithCity();
    _fadeController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    _fadeAnimation =
        CurvedAnimation(parent: _fadeController, curve: Curves.easeIn);
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("View Weather Details"),
          actions: <Widget>[
            new Container(
              margin: const EdgeInsets.all(7.0),
              child: new CircleAvatar(
                backgroundImage: new AssetImage('assets/profile.JPG'),
                radius: 22.0,
                backgroundColor: Colors.grey,
              ),
            ),
          ],
        ),
        body: Material(
          child: Container(
            constraints: BoxConstraints.expand(),
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: BlocBuilder(
                  bloc: _weatherBloc,
                  builder: (_, WeatherState weatherState) {
                    if (weatherState is WeatherLoaded) {
                      this.cityname = weatherState.weather.cityName;
                      _fadeController.reset();
                      _fadeController.forward();
                      return WeatherWidget(
                        weather: weatherState.weather,
                      );
                    } else if (weatherState is WeatherError ||
                        weatherState is WeatherEmpty) {
                      String errorText =
                          'There was an error fetching weather data';
                      if (weatherState is WeatherError) {
                        if (weatherState.errorCode == 404 ) {
                          errorText =
                              'We have trouble fetching weather for $cityname';
                        }
                      }
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.error_outline,
                            color: Colors.redAccent,
                            size: 24,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            errorText,
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          FlatButton(
                            child: Text(
                              "Try Again",
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                            onPressed: _fetchWeatherWithCity,
                          )
                        ],
                      );
                    } else if (weatherState is WeatherLoading) {
                      return Center(
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.white,
                        ),
                      );
                    }
                  }),
            ),
          ),
        ));
  }

  _fetchWeatherWithCity() {
    _weatherBloc.dispatch(FetchWeather(cityName: cityname));
  }
}
