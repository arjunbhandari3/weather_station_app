import 'package:flutter/material.dart';
import 'package:weather_station/src/screens/routes.dart';
import 'package:bloc/bloc.dart';
import 'package:weather_station/src/widgets/appContainer.dart';
import 'package:weather_station/src/repository/auth.dart';
import 'package:scoped_model/scoped_model.dart';

// import 'ui/lockedscreen/home.dart';
// import 'ui/lockedscreen/settings.dart';
// import 'ui/signin/newaccount.dart';
import 'package:weather_station/src/screens/login.dart';
import 'package:weather_station/src/screens/home_screen.dart';
void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(AppStateContainer(child: WeatherApp()));
}

class SimpleBlocDelegate extends BlocDelegate {
  @override
  onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }
}

class WeatherApp extends StatefulWidget {
  @override
  _WeatherAppState createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  final AuthModel _auth = new AuthModel();

  @override
  void initState() {
    try {
      _auth.loadSettings();
    } catch (e) {
      print("Error Loading Settings: $e");
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<AuthModel>(
      model: _auth,
      child: MaterialApp(
        title: 'Weather Station',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: new ScopedModelDescendant<AuthModel>(
          builder: (context, child, model) {
            if (model?.user != null) return HomeScreen();
            return LoginPage();
          },
        ),
        routes: Routes.mainRoute,
        // routes: <String, WidgetBuilder>{
        //   "/login": (BuildContext context) => LoginPage(),
        //   "/menu": (BuildContext context) => Home(),
        //   "/home": (BuildContext context) => Home(),
        //   "/settings": (BuildContext context) => SettingsPage(),
        //   "/create": (BuildContext context) => CreateAccount(),
        // },
      ),
    );
  }
}
