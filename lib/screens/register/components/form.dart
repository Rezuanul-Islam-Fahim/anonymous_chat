import 'dart:async';

import 'package:flutter/material.dart';

import 'package:anonymous_chat/common.dart';
import 'package:anonymous_chat/services/auth/auth.dart';
import 'package:anonymous_chat/services/navigation.dart';
import 'package:anonymous_chat/components/general_button.dart';
import 'package:anonymous_chat/screens/register/components/input_field.dart';

// Register screen's form widget
class RegisterForm extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Register handler
  Future<void> _register(BuildContext context) async {
    Navigation(
      status: await AuthService.register(
        name: _nameController.text,
        email: _emailController.text,
        password: _passwordController.text,
      ),
      successMessage: 'Successfully registered new account',
      errorMessageTitle: 'Registration failed',
    ).loginRegister(context);
  }

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
              // If form validation passes, then _register
              // handler will be called
              _register(context);
            }
          }),
        ],
      ),
    );
  }
}
