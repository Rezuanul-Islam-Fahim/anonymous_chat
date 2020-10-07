import 'dart:async';

import 'package:flutter/material.dart';

import 'package:anonymous_chat/services/auth/auth.dart';
import 'package:anonymous_chat/services/navigation.dart';
import 'package:anonymous_chat/components/general_button.dart';
import 'package:anonymous_chat/screens/change_password/components/input_field.dart';

class ChangePasswordScreen extends StatelessWidget {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // This function will handle all operations
  // required for change-password process
  Future<void> _changePassword(BuildContext context) async {
    Navigation(
      status: await AuthService.changePassword(
        newPassword: _passwordController.text,
      ),
      successMessage: 'Successfully changed password',
      errorMessageTitle: 'Error occurred',
    ).navigate(context);
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
