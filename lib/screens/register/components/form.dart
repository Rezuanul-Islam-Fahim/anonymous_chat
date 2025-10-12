import 'package:flutter/material.dart';

import 'package:anonymous_chat/common.dart';
import 'package:anonymous_chat/components/general_button.dart';
import 'package:anonymous_chat/screens/register/components/input_field.dart';

// Register screen's form widget
class RegisterForm extends StatefulWidget {
  const RegisterForm(
    this.nameController,
    this.emailController,
    this.passwordController,
    this.handler,
  );

  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final Function handler;

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: <Widget>[
          nameField(widget.nameController),
          SizedBox(height: 20),
          emailField(widget.emailController, 'Email'),
          SizedBox(height: 20),
          passwordField(widget.passwordController),
          SizedBox(height: 20),
          GeneralButton('Register Now', () {
            if (formKey.currentState!.validate()) {
              // If form validation passes, then register
              // handler will be called
              widget.handler();
            }
          }),
        ],
      ),
    );
  }
}
