import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:email_validator/email_validator.dart';

import '../global.dart';
import '../services/auth.dart';
import '../services/auth_exception.dart';
import '../components/login_register_button.dart';
import '../components/flush_message.dart';
import 'register.dart';
import 'chat.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
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
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
        padding: const EdgeInsets.only(top: 60, left: 15, right: 15),
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              child: Hero(
                tag: 'logo',
                child: Image.asset(
                  'assets/images/logo.png',
                  height: 150,
                  width: 150,
                ),
              ),
            ),
            Text(
              'Anonymous Chat',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: Colors.grey[800],
              ),
            ),
            SizedBox(height: 40),
            _buildForm(context),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Don\'t have an account? ',
                  style: TextStyle(fontSize: 16),
                ),
                GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => RegisterScreen()),
                  ),
                  child: Text(
                    'Register Now',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildForm(BuildContext context) {
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
