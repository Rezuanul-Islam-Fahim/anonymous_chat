import 'dart:async';

import 'package:anonymous_chat/components/circular_loader.dart';
import 'package:flutter/material.dart';

import 'package:anonymous_chat/services/auth/auth.dart';
import 'package:anonymous_chat/services/navigation.dart';
import 'package:anonymous_chat/components/general_button.dart';
import 'package:anonymous_chat/screens/change_password/components/input_field.dart';
import 'package:anonymous_chat/screens/login/login.dart';

class ChangePasswordScreen extends StatefulWidget {
  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  Future<void> _changePassword(BuildContext context) async {
    setState(() => _isLoading = true);

    Navigation(
      status: await AuthService.changePassword(
        newPassword: _passwordController.text,
      ),
      successMessage: 'Successfully changed password',
      errorMessageTitle: 'Error occurred',
      navigationScreen: LoginScreen(),
    ).navigate(context);

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Change Password')),
      body: Stack(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(25, 40, 25, 0),
            child: Form(
              key: _formKey,
              child: Column(
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
          if (_isLoading) Loader('Changing Password ...'),
        ],
      ),
    );
  }
}
