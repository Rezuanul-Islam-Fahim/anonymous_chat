import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'login.dart';

class SettingScreen extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _logOut(BuildContext context) async {
    final SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.clear();
    _auth.signOut();

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => LoginScreen()),
      (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Setting'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              child: Icon(
                Icons.account_circle,
                size: 120,
                color: Colors.grey[800],
              ),
            ),
            Text(
              'Rezuanul Islam Fahim',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 5),
            Text(
              'rifahim98@gmail.com',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 40),
            Column(
              children: <Widget>[
                SettingButtons(Icons.lock_outlined, 'Change Password'),
                SettingButtons(Icons.logout, 'Log Out'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SettingButtons extends StatelessWidget {
  final dynamic icon;
  final String label;

  SettingButtons(this.icon, this.label);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.grey[350],
      onTap: () => print('done'),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
        child: Row(
          children: <Widget>[
            Icon(icon, size: 25, color: Colors.grey[700]),
            SizedBox(width: 10),
            Text(
              label,
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w700,
                color: Colors.grey[700],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
