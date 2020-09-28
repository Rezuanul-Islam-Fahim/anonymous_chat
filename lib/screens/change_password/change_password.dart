import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:anonymous_chat/common.dart';
import 'package:anonymous_chat/components/login_register_button.dart';
import 'package:anonymous_chat/components/flush_message.dart';
import 'package:anonymous_chat/screens/chat/chat.dart';

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
      MaterialPageRoute(builder: (_) => ChatScreen()),
      (Route<dynamic> route) => false,
    );

    FlushMessage(
      message: 'Successfully changed password',
      icon: Icons.info_outline,
      color: Colors.green,
    ).show(context);
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
                  Icons.vpn_key,
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
                  Icons.vpn_key,
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
