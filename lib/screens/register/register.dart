import 'dart:async';

import 'package:flutter/material.dart';

import 'package:anonymous_chat/services/auth/auth.dart';
import 'package:anonymous_chat/services/auth/auth_navigation.dart';
import 'package:anonymous_chat/services/responsive.dart';
import 'package:anonymous_chat/components/circular_loader.dart';
import 'package:anonymous_chat/components/login_register_header.dart';
import 'package:anonymous_chat/screens/register/components/form.dart';
import 'package:anonymous_chat/screens/register/components/back_button.dart';
import 'package:anonymous_chat/screens/chat/chat.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  // Register handler
  Future<void> _register(BuildContext context) async {
    // Enable loader when registering
    setState(() => _isLoading = true);

    // If a user is successfully registered a new account, this method
    // will navigate user to chat screen. If registering fails,
    // then an error message will be shown
    AuthNavigation(
      status: await AuthService.register(
        name: _nameController.text,
        email: _emailController.text,
        password: _passwordController.text,
      ),
      successMessage: 'Successfully registered a new account',
      errorMessageTitle: 'Registration Failed',
      navigationScreen: ChatScreen(),
    ).navigate(context);

    // Disable loader when successfully registered a new account
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
              padding: EdgeInsets.symmetric(horizontal: 25),
              height: _isPortrait ? MediaQuery.of(context).size.height : null,
              alignment: Alignment.center,
              child: Container(
                width: Responsive(MediaQuery.of(context)).width(400),
                child: Column(
                  children: <Widget>[
                    Header(),
                    RegisterForm(
                      _nameController,
                      _emailController,
                      _passwordController,
                      () => _register(context),
                    ),
                    if (!_isPortrait) SizedBox(height: 100),
                  ],
                ),
              ),
            ),
          ),
          RegisterBackButton(),
          if (_isLoading) Loader('Registering new account...'),
        ],
      ),
    );
  }
}
