import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flushbar/flushbar.dart';

import '../global.dart';
import '../components/login_register_button.dart';
import 'chat.dart';

class RegisterScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> _registerUser(BuildContext context) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final SharedPreferences _prefs = await SharedPreferences.getInstance();

    final String _email = _emailController.text;
    final String _password = _passwordController.text;
    UserCredential _user;

    try {
      _user = await _auth.createUserWithEmailAndPassword(
        email: _email,
        password: _password,
      );
    } catch (e) {
      print(e.toString());
      Flushbar(
        title: 'Registration Failed',
        message: 'The email address is already in use by another account',
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
      _firestore.collection('users').doc(_user.user.uid).set({
        'name': _nameController.text,
      });

      await _prefs.setString('userEmail', _email);
      await _prefs.setString('userPassword', _password);

      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => ChatScreen()),
        (Route<dynamic> route) => false,
      );

      Flushbar(
        message: 'Successfully registered new account',
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
      body: Stack(
        children: <Widget>[
          Padding(
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
                          'Name',
                          Icon(Icons.account_circle_outlined),
                        ),
                        controller: _nameController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Name is required';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        decoration: inputField(
                          'E-mail',
                          Icon(Icons.email_outlined),
                        ),
                        controller: _emailController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Email is required';
                          } else if (!EmailValidator.validate(value)) {
                            return 'Invalid E-mail address';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        decoration: inputField(
                          'Password',
                          Icon(Icons.vpn_key_outlined),
                        ),
                        controller: _passwordController,
                        obscureText: true,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Password is required';
                          } else if (value.length < 6) {
                            return 'Password should be at least 6 characters';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      LoginRegisterButton(
                        'Register Now',
                        () {
                          if (_formKey.currentState.validate()) {
                            _registerUser(context);
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 35, left: 15),
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              iconSize: 30,
              color: Colors.grey[700],
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
        ],
      ),
    );
  }
}
