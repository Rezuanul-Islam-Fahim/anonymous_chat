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
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  // Register handler
  Future<void> register(BuildContext context) async {
    // Enable loader when registering
    setState(() => isLoading = true);

    // If a user is successfully registered a new account, this method
    // will navigate user to chat screen. If registering fails,
    // then an error message will be shown
    AuthNavigation(
      status: await AuthService.register(
        name: nameController.text,
        email: emailController.text,
        password: passwordController.text,
      ),
      successMessage: 'Successfully registered a new account',
      errorMessageTitle: 'Registration Failed',
      navigationScreen: ChatScreen(),
    ).navigate(context);

    // Disable loader when successfully registered a new account
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final bool isPortrait = mediaQuery.orientation == Orientation.portrait;

    return Scaffold(
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              height: isPortrait ? mediaQuery.size.height : null,
              alignment: Alignment.center,
              child: Container(
                width: Responsive(mediaQuery).width(400),
                child: Stack(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Header(),
                        RegisterForm(
                          nameController,
                          emailController,
                          passwordController,
                          () => register(context),
                        ),
                      ],
                    ),
                    RegisterBackButton(),
                    if (!isPortrait) const SizedBox(height: 100),
                  ],
                ),
              ),
            ),
          ),
          if (isLoading) const Loader('Registering new account...'),
        ],
      ),
    );
  }
}
