import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:anonymous_chat/components/flush_message.dart';
import 'package:anonymous_chat/screens/login/login.dart';

void openDialogue(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Logout'),
        content: Text('Are you sure to logout?'),
        actions: <Widget>[
          FlatButton(
            child: Text('Cancel'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          FlatButton(
            child: Text('Logout'),
            onPressed: () => _logOut(context),
          ),
        ],
      );
    },
  );
}

Future<void> _logOut(BuildContext context) async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  _prefs.clear();
  FirebaseAuth.instance.signOut();

  Navigator.of(context).pushAndRemoveUntil(
    MaterialPageRoute(builder: (_) => LoginScreen()),
    (Route<dynamic> route) => false,
  );

  FlushMessage(
    message: 'Successfully logged out',
    icon: Icons.info_outline,
    color: Colors.green,
  ).show(context);
}
