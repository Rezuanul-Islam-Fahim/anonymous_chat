import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:anonymous_chat/services/auth/auth.dart';
import 'package:anonymous_chat/components/general_button.dart';
import 'package:anonymous_chat/components/flush_message.dart';
import 'package:anonymous_chat/screens/change_password/components/input_field.dart';
import 'package:anonymous_chat/screens/chat/chat.dart';

class ChangePasswordScreen extends StatelessWidget {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // This function will handle all operations
  // required for change-password process
  Future<void> _changePassword(BuildContext context) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();

    // Do recent-login operation for changing-password
    AuthService.login(
      email: _prefs.getString('userEmail'),
      password: _prefs.getString('userPassword'),
    );

    // Update password handler
    FirebaseAuth.instance.currentUser.updatePassword(
      _passwordController.text,
    );

    // Update password in local storage
    await _prefs.setString('userPassword', _passwordController.text);

    // Navigate to chat screen
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => ChatScreen()),
      (Route<dynamic> route) => false,
    );

    // Show success message
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
              GeneralButton('Change Password', () {
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
