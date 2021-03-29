import 'package:flutter/material.dart';
import 'package:weather_station/src/widgets/appContainer.dart';
import 'package:weather_station/src/utils/converters.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool val = true;

  onSwitchValueChanged(bool newVal) {
    setState(() {
      val = newVal;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 10, right: 10, top: 15),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 15, left: 8, right: 8, bottom: 8),
                    child: Text(
                      "Unit",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8)),
                      color: Colors.black.withOpacity(0.1),
                    ),
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "Celsius",
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        Radio(
                          value: TemperatureUnit.celsius.index,
                          groupValue: AppStateContainer.of(context)
                              .temperatureUnit
                              .index,
                          onChanged: (value) {
                            AppStateContainer.of(context).updateTemperatureUnit(
                                TemperatureUnit.values[value]);
                          },
                          activeColor: Colors.blue,
                        )
                      ],
                    ),
                  ),
                  Divider(
                    color: Colors.white,
                    height: 1,
                  ),
                  Container(
                    color: Colors.black.withOpacity(0.1),
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "Fahrenheit",
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        Radio(
                          value: TemperatureUnit.fahrenheit.index,
                          groupValue: AppStateContainer.of(context)
                              .temperatureUnit
                              .index,
                          onChanged: (value) {
                            AppStateContainer.of(context).updateTemperatureUnit(
                                TemperatureUnit.values[value]);
                          },
                          activeColor: Colors.blue,
                        )
                      ],
                    ),
                  ),
                  Divider(
                    color: Colors.white,
                    height: 1,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(8),
                          bottomRight: Radius.circular(8)),
                      color: Colors.black.withOpacity(0.1),
                    ),
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "Kelvin",
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        Radio(
                          value: TemperatureUnit.kelvin.index,
                          groupValue: AppStateContainer.of(context)
                              .temperatureUnit
                              .index,
                          onChanged: (value) {
                            AppStateContainer.of(context).updateTemperatureUnit(
                                TemperatureUnit.values[value]);
                          },
                          activeColor: Colors.blue,
                        )
                      ],
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
