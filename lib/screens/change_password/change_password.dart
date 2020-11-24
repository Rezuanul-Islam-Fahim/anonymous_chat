import 'dart:async';

import 'package:flutter/material.dart';

import 'package:anonymous_chat/services/auth/auth.dart';
import 'package:anonymous_chat/services/auth/auth_navigation.dart';
import 'package:anonymous_chat/components/circular_loader.dart';
import 'package:anonymous_chat/screens/change_password/components/form.dart';
import 'package:anonymous_chat/screens/login/login.dart';

class ChangePasswordScreen extends StatefulWidget {
  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();
  bool _isLoading = false;

  // This function will handle changing-password functionality
  Future<void> _changePassword(BuildContext context) async {
    // Enable the loader when changing password
    setState(() => _isLoading = true);

    // If password is successfully changed, this method will logout
    // user and navigate to login screen, if changing password is
    // not successful, then an error message will be shown
    AuthNavigation(
      status: await AuthService.changePassword(
        newPassword: _passwordController.text,
      ),
      successMessage: 'Successfully changed password',
      errorMessageTitle: 'Error occurred',
      navigationScreen: LoginScreen(),
    ).navigate(context);

    // Disable the loader after password is changed
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Change Password')),
      body: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.fromLTRB(25, 40, 25, 0),
                alignment: Alignment.center,
                child: ChangePasswordForm(
                  _passwordController,
                  _confirmPassController,
                  _changePassword,
                ),
              ),
            ),
          ),
          if (_isLoading) Loader('Changing Password...'),
        ],
      ),
    );
  }
}
