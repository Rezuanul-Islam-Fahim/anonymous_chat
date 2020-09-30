import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:anonymous_chat/services/auth/auth_exception.dart';
import 'package:anonymous_chat/components/flush_message.dart';
import 'package:anonymous_chat/screens/chat/chat.dart';

// This class will be used for auth handling
class AuthHandler {
  AuthHandler({
    this.emailController,
    this.passwordController,
    this.status,
    this.successMessage,
    this.errorMessageTitle,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;
  final AuthResultStatus status;
  final String successMessage;
  final String errorMessageTitle;

  // This handler will be used for handling after operations of
  // auth process. Like, if auth operation is successful then
  // it will navigate to chat-screen and show success message.
  // Else it will show error message
  Future<void> submit(BuildContext context) async {
    if (status == AuthResultStatus.successful) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => ChatScreen()),
        (Route<dynamic> route) => false,
      );

      // Success message
      FlushMessage(
        message: successMessage,
        icon: Icons.info_outline,
        color: Colors.green,
      ).show(context);

      // Store credentials to local storage
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      _prefs.setString('userEmail', emailController.text);
      _prefs.setString('userPassword', passwordController.text);
    } else {
      String _errorMessage = AuthExceptionHandler.generateErrorMessage(status);

      // Error message
      FlushMessage(
        title: errorMessageTitle,
        message: _errorMessage,
        icon: Icons.info_outline,
        color: Colors.red,
      ).show(context);
    }
  }
}
