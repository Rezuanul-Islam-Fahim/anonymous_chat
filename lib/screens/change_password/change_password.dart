import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:anonymous_chat/components/login_register_button.dart';
import 'package:anonymous_chat/components/flush_message.dart';
import 'package:anonymous_chat/screens/change_password/components/input_field.dart';
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
      appBar: AppBar(title: Text('Change Password')),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              passwordField(
                'Enter New Password',
                _passwordController,
                _confirmPassController,
              ),
              SizedBox(height: 20),
              passwordField(
                'Confirm Password',
                _confirmPassController,
                _passwordController,
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
