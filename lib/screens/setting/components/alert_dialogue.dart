import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:anonymous_chat/components/flush_message.dart';
import 'package:anonymous_chat/screens/login/login.dart';

// This function will open logout dialogue
void openDialogue(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Logout'),
        content: Text('Are you sure to Logout?'),
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
            color: Colors.redAccent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            child: Text('Logout'),
            onPressed: () => _logOut(context),
          ),
        ],
        contentPadding: EdgeInsets.fromLTRB(25, 15, 25, 10),
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
  SharedPreferences _prefs = await SharedPreferences.getInstance();

  // Clear credentials from local storgae
  _prefs.clear();

  // Logout
  FirebaseAuth.instance.signOut();

  // Navigate to login screen after
  // successfully logout
  Navigator.of(context).pushAndRemoveUntil(
    MaterialPageRoute(builder: (_) => LoginScreen()),
    (Route<dynamic> route) => false,
  );

  // Show message after logout
  FlushMessage(
    message: 'Successfully Logged Out',
    icon: Icons.info_outline,
    color: Colors.green,
  ).show(context);
}
