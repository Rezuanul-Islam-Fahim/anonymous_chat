import 'package:flutter/material.dart';

import 'package:anonymous_chat/common.dart';
import 'package:anonymous_chat/components/general_button.dart';
import 'package:anonymous_chat/screens/register/components/input_field.dart';

// Register screen's form widget
class RegisterForm extends StatelessWidget {
  RegisterForm(
    this._nameController,
    this._emailController,
    this._passwordController,
    this._handler,
  );

  final TextEditingController _nameController;
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
          nameField(_nameController),
          SizedBox(height: 20),
          emailField(_emailController, 'Email'),
          SizedBox(height: 20),
          passwordField(_passwordController),
          SizedBox(height: 20),
          GeneralButton('Register Now', () {
            if (_formKey.currentState.validate()) {
              // If form validation passes, then register
              // handler will be called
              _handler();
            }
          }),
        ],
      ),
    );
  }
}
