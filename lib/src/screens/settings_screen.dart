import 'package:flutter/material.dart';
import 'package:weather_station/src/widgets/appContainer.dart';
import 'package:weather_station/src/utils/converters.dart';
import 'package:weather_station/src/repository/auth.dart';
import 'package:scoped_model/scoped_model.dart';

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
    final _auth = ScopedModel.of<AuthModel>(context, rebuildOnChange: true);
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
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
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 15, left: 8, right: 8, bottom: 8),
                    child: Text(
                      " ",
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8),
                        bottomLeft: Radius.circular(8),
                        bottomRight: Radius.circular(8),
                      ),
                      color: Colors.black.withOpacity(0.1),
                    ),
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "Log out",
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.power_settings_new),
                          onPressed: () => _auth.logout(),
                        ),
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
