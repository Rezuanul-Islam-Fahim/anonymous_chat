import 'package:flutter/material.dart';

import 'package:anonymous_chat/common.dart';
import 'package:anonymous_chat/components/general_button.dart';
import 'package:anonymous_chat/screens/login/components/input_field.dart';

// Login screen's form widget
class LoginForm extends StatefulWidget {
  const LoginForm(this.emailController, this.passwordController, this.handler);

  final TextEditingController emailController;
  final TextEditingController passwordController;
  final Function handler;

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: <Widget>[
          emailField(widget.emailController, 'Enter your Email'),
          const SizedBox(height: 20),
          passwordField(widget.passwordController),
          const SizedBox(height: 20),
          GeneralButton('Login', () {
            if (formKey.currentState.validate()) {
              // If form validation passes, then login
              // handler will be called
              widget.handler();
            }
          }),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
