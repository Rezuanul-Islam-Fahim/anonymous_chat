import 'dart:async';

import 'package:flutter/material.dart';

import 'package:anonymous_chat/services/auth/auth.dart';
import 'package:anonymous_chat/services/navigation.dart';
import 'package:anonymous_chat/components/circular_loader.dart';
import 'package:anonymous_chat/components/login_register_header.dart';
import 'package:anonymous_chat/screens/register/components/form.dart';
import 'package:anonymous_chat/screens/register/components/back_button.dart';

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
    setState(() => _isLoading = true);

    Navigation(
      status: await AuthService.register(
        name: _nameController.text,
        email: _emailController.text,
        password: _passwordController.text,
      ),
      successMessage: 'Successfully registered new account',
      errorMessageTitle: 'Registration failed',
    ).navigate(context);

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
              top: 60,
              left: 25,
              right: 25,
            ),
            child: Column(
              children: <Widget>[
                Header(),
                RegisterForm(
                  _nameController,
                  _emailController,
                  _passwordController,
                  () => _register(context),
                ),
              ],
            ),
          ),
          RegisterBackButton(),
          if (_isLoading) Loader('Registering New Account ...'),
        ],
      ),
    );
  }
}
