import 'package:flutter/material.dart';
import 'package:weather_station/src/api/weather_api_client.dart';
import 'package:weather_station/src/bloc/weather_bloc.dart';
import 'package:weather_station/src/bloc/weather_event.dart';
import 'package:weather_station/src/bloc/weather_state.dart';
import 'package:weather_station/src/repository/weather_repository.dart';
import 'package:weather_station/src/api/api_keys.dart';
import 'package:weather_station/src/widgets/home_weather_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class WeatherScreen extends StatefulWidget {
  final WeatherRepository weatherRepository = WeatherRepository(
      weatherApiClient: WeatherApiClient(
          httpClient: http.Client(), apiKey: ApiKey.OPEN_WEATHER_MAP));
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen>
    with TickerProviderStateMixin {
  WeatherBloc _weatherBloc;
  String _cityName = 'dhulikhel';
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
          title: Text("Weather Station"),
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
                      this._cityName = weatherState.weather.cityName;
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
                        if (weatherState.errorCode == 404) {
                          errorText =
                              'We have trouble fetching weather for $_cityName';
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
    _weatherBloc.dispatch(FetchWeather(cityName: _cityName));
  }
}
