import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:anonymous_chat/services/auth/auth_exception.dart';
import 'package:anonymous_chat/components/flush_message.dart';
import 'package:anonymous_chat/screens/chat/chat.dart';

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

  Future<void> submit(BuildContext context) async {
    if (status == AuthResultStatus.successful) {
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      _prefs.setString('userEmail', emailController.text);
      _prefs.setString('userPassword', passwordController.text);

      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => ChatScreen()),
        (Route<dynamic> route) => false,
      );

      FlushMessage(
        message: successMessage,
        icon: Icons.info_outline,
        color: Colors.green,
      ).show(context);

      emailController.clear();
      passwordController.clear();
    } else {
      String _errorMessage = AuthExceptionHandler.generateErrorMessage(status);

      FlushMessage(
        title: errorMessageTitle,
        message: _errorMessage,
        icon: Icons.info_outline,
        color: Colors.red,
      ).show(context);
    }
  }
}
