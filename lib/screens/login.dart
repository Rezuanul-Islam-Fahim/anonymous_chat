import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flushbar/flushbar.dart';

import '../global.dart';
import '../components/login_register_button.dart';
import 'register.dart';
import 'chat.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> _loginUser(BuildContext context) async {
    final SharedPreferences _prefs = await SharedPreferences.getInstance();

    final String _email = _emailController.text;
    final String _password = _passwordController.text;
    UserCredential _user;

    try {
      _user = await _auth.signInWithEmailAndPassword(
        email: _email,
        password: _password,
      );
    } catch (e) {
      print(e.toString());
      Flushbar(
        title: 'Login Failed',
        message: 'Incorrect E-mail address or Password entered',
        icon: Icon(
          Icons.info_outline,
          size: 30,
          color: Colors.redAccent,
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

    if (_user != null) {
      await _prefs.setString('userEmail', _email);
      await _prefs.setString('userPassword', _password);

      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => ChatScreen(_user)),
        (Route<dynamic> route) => false,
      );

      Flushbar(
        message: 'Successfully logged In',
        icon: Icon(
          Icons.info_outline,
          size: 30,
          color: Colors.greenAccent,
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

      _emailController.clear();
      _passwordController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
        padding: const EdgeInsets.only(top: 60, left: 15, right: 15),
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              child: Hero(
                tag: 'logo',
                child: Image.asset(
                  'assets/images/logo.png',
                  height: 150,
                  width: 150,
                ),
              ),
            ),
            Text(
              'Anonymous Chat',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: Colors.grey[800],
              ),
            ),
            SizedBox(height: 40),
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: inputField(
                      'Enter your E-mail',
                      Icon(Icons.email_outlined),
                    ),
                    controller: _emailController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Email is required';
                      } else if (!EmailValidator.validate(value)) {
                        return 'Invalid Email Address';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    decoration: inputField(
                      'Enter your Password',
                      Icon(Icons.vpn_key_outlined),
                    ),
                    controller: _passwordController,
                    obscureText: true,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Password is required';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  LoginRegisterButton('Login', () {
                    if (_formKey.currentState.validate()) {
                      _loginUser(context);
                    }
                  }),
                ],
              ),
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Don\'t have an account? ',
                  style: TextStyle(fontSize: 16),
                ),
                GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => RegisterScreen()),
                  ),
                  child: Text(
                    'Register Now',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
