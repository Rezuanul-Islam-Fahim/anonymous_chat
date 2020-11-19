import 'package:flutter/material.dart';

import 'package:anonymous_chat/common.dart';
import 'package:anonymous_chat/components/general_button.dart';
import 'package:anonymous_chat/screens/login/components/input_field.dart';

// Login screen's form widget
class LoginForm extends StatefulWidget {
  LoginForm(this._emailController, this._passwordController, this._handler);

  final TextEditingController _emailController;
  final TextEditingController _passwordController;
  final Function _handler;

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          emailField(widget._emailController, 'Enter your Email'),
          SizedBox(height: 20),
          passwordField(widget._passwordController),
          SizedBox(height: 20),
          GeneralButton('Login', () {
            if (_formKey.currentState.validate()) {
              // If form validation passes, then login
              // handler will be called
              widget._handler();
            }
          }),
          SizedBox(height: 30),
        ],
      ),
    );
  }
}
