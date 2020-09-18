import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flushbar/flushbar.dart';

import '../global.dart';
import '../components/login_register_button.dart';
import 'chat.dart';

class ChangePasswordScreen extends StatelessWidget {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> _changePassword(BuildContext context) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    FirebaseAuth _auth = FirebaseAuth.instance;
    UserCredential _user = await _auth.signInWithEmailAndPassword(
      email: _prefs.getString('userEmail'),
      password: _prefs.getString('userPassword'),
    );

    _user.user.updatePassword(_passwordController.text);
    await _prefs.setString('userPassword', _passwordController.text);

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => ChatScreen(_user)),
      (Route<dynamic> route) => false,
    );

    Flushbar(
      message: 'Successfully changed password',
      icon: Icon(
        Icons.info_outline,
        size: 30,
        color: Colors.green,
      ),
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.fromLTRB(20, 15, 15, 15),
      borderRadius: 10,
      duration: Duration(seconds: 4),
      boxShadows: <BoxShadow>[
        BoxShadow(
          color: Colors.black45,
          blurRadius: 5,
          spreadRadius: 2,
        ),
      ],
    )..show(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Change Password'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                decoration: inputField(
                  'Enter New Password',
                  Icon(Icons.vpn_key_outlined),
                ),
                controller: _passwordController,
                obscureText: true,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Required field';
                  } else if (value.length < 6) {
                    return 'Password should be at least 6 characters';
                  } else if (_confirmPassController.text !=
                      _passwordController.text) {
                    return 'New and confirm password field doesn\'t match';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                decoration: inputField(
                  'Confirm Password',
                  Icon(Icons.vpn_key_outlined),
                ),
                controller: _confirmPassController,
                obscureText: true,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Required field';
                  } else if (value.length < 6) {
                    return 'Password should be at least 6 characters';
                  } else if (_confirmPassController.text !=
                      _passwordController.text) {
                    return 'New and confirm password field doesn\'t match';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              LoginRegisterButton('Change Password', () {
                if (_formKey.currentState.validate()) {
                  _changePassword(context);
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}
