import 'dart:async';

import 'package:flutter/material.dart';

import 'package:anonymous_chat/services/auth/auth_exception.dart';
import 'package:anonymous_chat/components/flush_message.dart';

// This class is used for Navigation. When some operation success
// or fails. Like login, register, change-password
class AuthNavigation {
  AuthNavigation({
    this.status,
    this.successMessage,
    this.errorMessageTitle,
    this.navigationScreen,
  });

  final AuthResultStatus status;
  final String successMessage;
  final String errorMessageTitle;
  final Widget navigationScreen;

  // This handler is used for handling after operations of
  // auth process. Like, if auth operation is successful then
  // it will navigate to a new screen and show success message.
  // Else it will show error message
  Future<void> navigate(BuildContext context) async {
    if (status == AuthResultStatus.successful) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => navigationScreen),
        (Route<dynamic> route) => false,
      );

      // Success message
      FlushMessage(
        message: successMessage,
        icon: Icons.info_outline,
        color: Colors.green,
      ).show(context);
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
