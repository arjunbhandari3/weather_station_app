import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:native_widgets/native_widgets.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:weather_station/src/utils/constants.dart';
import 'package:weather_station/src/repository/auth.dart';
import 'package:weather_station/src/widgets/popUp.dart';

class CreateAccount extends StatefulWidget {
  CreateAccountState createState() => CreateAccountState();
}

class CreateAccountState extends State<CreateAccount> {
  String _username, _password;

  final formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController _controllerUsername, _controllerPassword;

  @override
  initState() {
    _controllerUsername = TextEditingController();
    _controllerPassword = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _auth = ScopedModel.of<AuthModel>(context, rebuildOnChange: true);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          "Create Account",
          textScaleFactor: textScaleFactor,
        ),
      ),
      body: SafeArea(
        child: ListView(
          physics: AlwaysScrollableScrollPhysics(),
          key: PageStorageKey("Divider 1"),
          children: <Widget>[
            SizedBox(
              height: 20,
              width: double.infinity,
            ),
            Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
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
                          val.length < 5 ? 'Username must contain at least 5 characters.' : null,
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
                          val.length < 6 ? 'Password must contain at least 6 charcters.' : null,
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
                  'SIGN UP',
                  textScaleFactor: textScaleFactor,
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.blue,
                onPressed: () async {
                  final form = formKey.currentState;
                  if (form.validate()) {
                    form.save();
                    final snackbar = SnackBar(
                      duration: Duration(seconds: 30),
                      content: Row(
                        children: <Widget>[
                          NativeLoadingIndicator(),
                          Text("  Signing Up...")
                        ],
                      ),
                    );
                    _scaffoldKey.currentState.showSnackBar(snackbar);

                    _auth
                        .login(
                      username: _username.toString().toLowerCase().trim(),
                      password: _password.toString().trim(),
                    )
                        .then((result) async {
                      if (result) {
                        final snackbar = SnackBar(
                          duration: Duration(seconds: 3),
                          content: Row(
                            children: <Widget>[
                              NativeLoadingIndicator(),
                              Text("  Signing Up...")
                            ],
                          ),
                        );
                        _scaffoldKey.currentState.showSnackBar(snackbar);

                        await Future.delayed(Duration(seconds: 3));
                        _scaffoldKey.currentState.hideCurrentSnackBar();
                        Navigator.pop(context, true);
                      } else {
                        _scaffoldKey.currentState.hideCurrentSnackBar();
                        showAlertPopup(context, 'Info', _auth.errorMessage);
                      }
                    });
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
