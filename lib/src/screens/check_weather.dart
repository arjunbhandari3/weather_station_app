import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';

import 'package:weather_station/src/screens/view_search_weather_screen.dart';

class SearchWeatherScreen extends StatefulWidget {
  @override
  _SearchWeatherScreenState createState() => _SearchWeatherScreenState();
}

class _SearchWeatherScreenState extends State<SearchWeatherScreen> {
  String cityname;
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult> _connectivitySubscription;

  ConnectivityResult _connectivityResult;

  TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();
    _textEditingController = new TextEditingController();

    print("Search init state");

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      setState(() {
        _connectivityResult = result;
        print("Network $_connectivityResult");
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _textEditingController.dispose();
    _connectivitySubscription.cancel();
    print("Search dispose state");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Check Weather"),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 10, right: 10, top: 15),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new SizedBox(
              height: 8.0,
            ),
            new Text(
              "Check Weather By City",
              style: TextStyle(
                  fontSize: 23.0,
                  fontFamily: 'Butler',
                  fontWeight: FontWeight.w700),
            ),
            new SizedBox(height: 16.0),
            new Card(
              elevation: 4.0,
              child: new Padding(
                padding: const EdgeInsets.all(8.0),
                child: new TextField(
                  textInputAction: TextInputAction.go,
                  controller: _textEditingController,
                  cursorColor: Colors.black,
                  onSubmitted: ((cityname) {
                    print("Submit query");
                    if (_connectivityResult != ConnectivityResult.none) {
                      Navigator.push(
                        context,
                        new MaterialPageRoute(
                          builder: (BuildContext context) =>
                              new ViewSearchWeatherScreen(cityname),
                        ),
                      );
                      // Navigator.of(context).pushNamed("/viewsearchweather");
                    } else {
                      print("No internet Connection.");
                    }
                  }),
                  decoration: InputDecoration(
                    hintText: "Search city",
                    hintStyle: TextStyle(color: Colors.black),
                    prefixIcon: new Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: new Icon(Icons.search),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        Icons.close,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        if (_textEditingController.text.length > 0) {
                          _textEditingController.clear();
                        }
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showSnackBar(String message, BuildContext context) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 2),
    ));
  }

  void listenToNetwork() {}
}
