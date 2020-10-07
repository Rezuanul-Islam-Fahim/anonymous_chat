import 'dart:async';

import 'package:flutter/material.dart';

import 'package:anonymous_chat/common.dart';
import 'package:anonymous_chat/services/auth/auth.dart';
import 'package:anonymous_chat/services/navigation.dart';
import 'package:anonymous_chat/components/general_button.dart';
import 'package:anonymous_chat/screens/login/components/input_field.dart';

// Login screen's form widget
class LoginForm extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Login handler
  Future<void> _login(BuildContext context) async {
    Navigation(
      status: await AuthService.login(
        email: _emailController.text,
        password: _passwordController.text,
      ),
      successMessage: 'Successfully Logged In',
      errorMessageTitle: 'Login Failed',
    ).navigate(context);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          emailField(_emailController, 'Enter Your Email'),
          SizedBox(height: 20),
          passwordField(_passwordController),
          SizedBox(height: 20),
          GeneralButton('Login', () {
            if (_formKey.currentState.validate()) {
              // If form validation passes, then _login
              // handler will be called
              _login(context);
            }
          }),
          SizedBox(height: 30),
        ],
      ),
    );
  }
}
