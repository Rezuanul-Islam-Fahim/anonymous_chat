import 'dart:async';

import 'package:flutter/material.dart';

import 'package:anonymous_chat/services/auth/auth.dart';
import 'package:anonymous_chat/components/flush_message.dart';
import 'package:anonymous_chat/screens/login/login.dart';

// This function will open logout dialogue
void openDialogue(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Logout'),
        content: Text('Are you sure you want to Logout?'),
        actions: <Widget>[
          FlatButton(
            color: Colors.blueGrey,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            child: Text('Cancel'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          FlatButton(
            color: Colors.red,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            child: Text('Logout'),
            onPressed: () => _logOut(context),
          ),
        ],
        contentPadding: EdgeInsets.fromLTRB(25, 10, 25, 0),
        buttonPadding: EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 12,
        ),
      );
    },
  );
}

// Logout handler
Future<void> _logOut(BuildContext context) async {
  AuthService.logOut();

  // Navigate to login screen after successfully logout
  Navigator.of(context).pushAndRemoveUntil(
    MaterialPageRoute(builder: (_) => LoginScreen()),
    (Route<dynamic> route) => false,
  );

  // Show success message after logout
  FlushMessage(
    message: 'Successfully Logged Out',
    icon: Icons.info_outline,
    color: Colors.green,
  ).show(context);
}
