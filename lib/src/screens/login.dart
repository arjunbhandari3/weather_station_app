import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:native_widgets/native_widgets.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:weather_station/src/utils/constants.dart';
import 'package:weather_station/src/repository/auth.dart';
import 'package:weather_station/src/widgets/popUp.dart';
import 'package:weather_station/src/screens/signUp.dart';

class LoginPage extends StatefulWidget {

  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  String _status = 'no-action';
  String _username, _password;

  final formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController _controllerUsername, _controllerPassword;

  @override
  initState() {
    _controllerUsername = TextEditingController();
    _controllerPassword = TextEditingController();
    super.initState();
    print(_status);
  }

  @override
  Widget build(BuildContext context) {
    final _auth = ScopedModel.of<AuthModel>(context, rebuildOnChange: true);
    return Scaffold(
      backgroundColor: Colors.grey.shade700,
      key: _scaffoldKey,
      body: SingleChildScrollView(
        child: Stack(
          key: PageStorageKey("Divider 1"),
          children: <Widget>[
           SizedBox(
              height: 265,
              width: double.infinity,
              child: Image.asset(
                'assets/banner.jpg',
                fit: BoxFit.cover,
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(16.0, 200.0, 16.0, 16.0),
              child: Column(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(12.0),
                        margin: EdgeInsets.only(top: 16.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Form(
                                    key: formKey,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        ListTile(
                                          title: Text(
                                            "Weather Station",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 30,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                        Divider(color: Colors.grey),
                                        ListTile(
                                          title: TextFormField(
                                            decoration: InputDecoration(
                                              prefixIcon: Icon(
                                                Icons.person,
                                              ),
                                              labelText: "Username",
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(30.0),
                                              ),
                                            ),
                                            validator: (val) =>
                                                val.length < 5 ? 'Username Required' : null,
                                            onSaved: (val) => _username = val,
                                            obscureText: false,
                                            keyboardType: TextInputType.text,
                                            controller: _controllerUsername,
                                            autocorrect: false,
                                          ),
                                        ),
                                        ListTile(
                                          title: TextFormField(
                                            decoration: InputDecoration(
                                              prefixIcon: Icon(
                                                Icons.lock,
                                              ),
                                              labelText: "Password",
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(30.0),
                                              ),
                                            ),
                                            validator: (val) =>
                                                val.length < 5 ? 'Password Required' : null,
                                            onSaved: (val) => _password = val,
                                            obscureText: true,
                                            controller: _controllerPassword,
                                            keyboardType: TextInputType.text,
                                            autocorrect: false,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  ListTile(
                                    title: NativeButton(
                                      child: Text(
                                        'LOGIN',
                                        textScaleFactor: textScaleFactor,
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      color: Colors.blue,
                                      onPressed: () {
                                        final form = formKey.currentState;
                                        if (form.validate()) {
                                          form.save();
                                          final snackbar = SnackBar(
                                            duration: Duration(seconds: 30),
                                            content: Row(
                                              children: <Widget>[
                                                NativeLoadingIndicator(),
                                                Text("  Logging In...")
                                              ],
                                            ),
                                          );
                                          _scaffoldKey.currentState.showSnackBar(snackbar);

                                          setState(() => this._status = 'loading');
                                          _auth
                                              .login(
                                            username: _username.toString().toLowerCase().trim(),
                                            password: _password.toString().trim(),
                                          )
                                              .then((result) {
                                            if (result) {
                                            } else {
                                              setState(() => this._status = 'rejected');
                                              showAlertPopup(context, 'Info', _auth.errorMessage);
                                            }
                                            _scaffoldKey.currentState.hideCurrentSnackBar();
                                          });
                                        }
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                    width: double.infinity,
                                    child: Text(
                                      "Don't have an Account?",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                  ListTile(
                                    title: NativeButton(
                                      child: Text(
                                        'SIGN UP',
                                        textScaleFactor: textScaleFactor,
                                      ),
                                      color: Colors.grey.shade400,
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => CreateAccount(),
                                              fullscreenDialog: true),
                                        ).then((success) => success
                                            ? showAlertPopup(
                                                context, 'Info', "New Account Created, Login Now.")
                                            : null);
                                      },
                                    ),
                                  ),
                                ],
                              ),
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