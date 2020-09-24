import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

import 'package:anonymous_chat/global.dart';
import 'package:anonymous_chat/services/auth.dart';
import 'package:anonymous_chat/services/auth_exception.dart';
import 'package:anonymous_chat/components/flush_message.dart';
import 'package:anonymous_chat/components/login_register_button.dart';
import 'package:anonymous_chat/screens/chat/chat.dart';

class LoginForm extends StatelessWidget {
  LoginForm(this._emailController, this._passwordController);

  final TextEditingController _emailController;
  final TextEditingController _passwordController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> _login(BuildContext context) async {
    AuthResultStatus _status = await AuthService.login(
      email: _emailController.text,
      password: _passwordController.text,
    );

    if (_status == AuthResultStatus.successful) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => ChatScreen()),
        (Route<dynamic> route) => false,
      );

      FlushMessage(
        message: 'Successfully logged In',
        icon: Icons.info_outline,
        color: Colors.green,
      ).show(context);

      _emailController.clear();
      _passwordController.clear();
    } else {
      String _errorMessage = AuthExceptionHandler.generateErrorMessage(_status);

      FlushMessage(
        title: 'Login Failed',
        message: _errorMessage,
        icon: Icons.info_outline,
        color: Colors.red,
      ).show(context);
    }
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
        ],
      ),
    );
  }
}
