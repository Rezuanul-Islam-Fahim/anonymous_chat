import 'dart:async';

import 'package:flutter/material.dart';

import 'package:anonymous_chat/commons.dart';
import 'package:anonymous_chat/services/auth/auth.dart';
import 'package:anonymous_chat/services/auth/auth_handler.dart';
import 'package:anonymous_chat/components/login_register_button.dart';
import 'package:anonymous_chat/screens/login/components/input_field.dart';

class LoginForm extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> _login(BuildContext context) async {
    AuthHandler(
      emailController: _emailController,
      passwordController: _passwordController,
      status: await AuthService.login(
        email: _emailController.text,
        password: _passwordController.text,
      ),
      successMessage: 'Successfully Logged In',
      errorMessageTitle: 'Login Failed',
    ).submit(context);
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
          LoginRegisterButton('Login', () {
            if (_formKey.currentState.validate()) {
              _login(context);
            }
          }),
          SizedBox(height: 30),
        ],
      ),
    );
  }
}