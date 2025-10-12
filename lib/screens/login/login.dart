import 'dart:async';

import 'package:flutter/material.dart';

import 'package:anonymous_chat/services/auth/auth.dart';
import 'package:anonymous_chat/services/auth/auth_navigation.dart';
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
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  // Login handler
  Future<void> login(BuildContext context) async {
    // Enable loader when logging in
    setState(() => isLoading = true);

    // If a user is successfully logged in, this method will navigate
    // user to chat screen. If logging fails, then an error
    // message will be shown
    AuthNavigation(
      status: await AuthService.login(
        email: emailController.text,
        password: passwordController.text,
      ),
      successMessage: 'Successfully Logged In',
      errorMessageTitle: 'Login Failed',
      navigationScreen: ChatScreen(),
    ).navigate(context);

    // Disable loader when successfully logged in
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
              height: isPortrait ? mediaQuery.size.height : null,
              padding: const EdgeInsets.symmetric(horizontal: 25),
              alignment: Alignment.center,
              child: SizedBox(
                width: Responsive(mediaQuery).width(400),
                child: Column(
                  children: <Widget>[
                    Header(),
                    LoginForm(
                      emailController,
                      passwordController,
                      () => login(context),
                    ),
                    RegisterLink(),
                    if (!isPortrait) const SizedBox(height: 100),
                  ],
                ),
              ),
            ),
          ),
          if (isLoading) Loader('Logging In...'),
        ],
      ),
    );
  }
}
