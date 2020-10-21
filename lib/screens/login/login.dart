import 'dart:async';

import 'package:flutter/material.dart';

import 'package:anonymous_chat/services/auth/auth.dart';
import 'package:anonymous_chat/services/navigation.dart';
import 'package:anonymous_chat/services/responsive.dart';
import 'package:anonymous_chat/components/circular_loader.dart';
import 'package:anonymous_chat/components/login_register_header.dart';
import 'package:anonymous_chat/screens/login/components/form.dart';
import 'package:anonymous_chat/screens/login/components/register_link.dart';
import 'package:anonymous_chat/screens/chat/chat.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  // Login handler
  Future<void> _login(BuildContext context) async {
    setState(() => _isLoading = true);

    Navigation(
      status: await AuthService.login(
        email: _emailController.text,
        password: _passwordController.text,
      ),
      successMessage: 'Successfully Logged In',
      errorMessageTitle: 'Login Failed',
      navigationScreen: ChatScreen(),
    ).navigate(context);

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    final bool _isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Container(
              height: _isPortrait ? MediaQuery.of(context).size.height : 650,
              padding: EdgeInsets.symmetric(horizontal: 25),
              alignment: Alignment.center,
              child: Container(
                width: Responsive(MediaQuery.of(context)).width(400),
                child: Column(
                  children: <Widget>[
                    Header(),
                    LoginForm(
                      _emailController,
                      _passwordController,
                      () => _login(context),
                    ),
                    RegisterLink(),
                  ],
                ),
              ),
            ),
          ),
          if (_isLoading) Loader('Logging In...'),
        ],
      ),
    );
  }
}
