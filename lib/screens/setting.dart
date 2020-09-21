import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../components/setting_buttons.dart';
import '../components/flush_message.dart';
import 'login.dart';
import 'change_password.dart';

class SettingScreen extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _logOut(BuildContext context) async {
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
              onPressed: () async {
                final SharedPreferences _prefs =
                    await SharedPreferences.getInstance();
                _prefs.clear();
                _auth.signOut();

                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => LoginScreen()),
                  (Route<dynamic> route) => false,
                );

                FlushMessage(
                  message: 'Successfully logged out',
                  icon: Icons.info_outline,
                  color: Colors.green,
                ).show(context);
              },
            ),
          ],
        );
      },
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
                SettingButtons(
                  Icons.vpn_key_outlined,
                  'Change Password',
                  () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => ChangePasswordScreen()),
                  ),
                ),
                SettingButtons(
                  Icons.logout,
                  'Log Out',
                  () => _logOut(context),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
