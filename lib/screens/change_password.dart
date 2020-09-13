import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../global.dart';
import '../components/login_register_button.dart';
import 'chat.dart';

class ChangePasswordScreen extends StatelessWidget {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();

  Future<void> _changePassword(BuildContext context) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();

    FirebaseAuth _auth = FirebaseAuth.instance;
    UserCredential _user = await _auth.signInWithEmailAndPassword(
      email: _prefs.getString('userEmail'),
      password: _prefs.getString('userPassword'),
    );

    if (_passwordController.text == _confirmPassController.text) {
      _user.user.updatePassword(_passwordController.text);

      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => ChatScreen(_user)),
        (Route<dynamic> route) => false,
      );

      await _prefs.setString('userPassword', _passwordController.text);
    } else {
      print('not match');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Change Password'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            TextField(
              decoration: inputField(
                'Enter New Password',
                Icon(Icons.vpn_key_outlined),
              ),
              controller: _passwordController,
              obscureText: true,
            ),
            SizedBox(height: 20),
            TextField(
              decoration: inputField(
                'Confirm Password',
                Icon(Icons.vpn_key_outlined),
              ),
              controller: _confirmPassController,
              obscureText: true,
            ),
            SizedBox(height: 20),
            LoginRegisterButton(
              'Change Password',
              () => _changePassword(context),
            ),
          ],
        ),
      ),
    );
  }
}
