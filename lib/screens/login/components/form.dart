import 'package:flutter/material.dart';

import 'package:anonymous_chat/common.dart';
import 'package:anonymous_chat/components/general_button.dart';
import 'package:anonymous_chat/screens/login/components/input_field.dart';

// Login screen's form widget
class LoginForm extends StatelessWidget {
  LoginForm(this._emailController, this._passwordController, this._handler);

  final TextEditingController _emailController;
  final TextEditingController _passwordController;
  final Function _handler;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
              // If form validation passes, then login
              // handler will be called
              _handler();
            }
          }),
          SizedBox(height: 30),
        ],
      ),
    );
  }
}
