import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

import 'package:anonymous_chat/global.dart';
import 'package:anonymous_chat/services/auth.dart';
import 'package:anonymous_chat/services/auth_handler.dart';
import 'package:anonymous_chat/components/login_register_button.dart';

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
    ).submit(context);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            decoration: inputField(
              'Enter your E-mail',
              Icon(Icons.email_outlined),
            ),
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value.isEmpty) {
                return 'Email is required';
              } else if (!EmailValidator.validate(value)) {
                return 'Invalid Email Address';
              }
              return null;
            },
          ),
          SizedBox(height: 20),
          TextFormField(
            decoration: inputField(
              'Enter your Password',
              Icon(Icons.vpn_key_outlined),
            ),
            controller: _passwordController,
            obscureText: true,
            validator: (value) {
              if (value.isEmpty) {
                return 'Password is required';
              }
              return null;
            },
          ),
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
