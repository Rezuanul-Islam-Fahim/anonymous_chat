import 'package:flutter/material.dart';

import 'package:anonymous_chat/screens/setting/components/link.dart';
import 'package:anonymous_chat/screens/setting/components/alert_dialogue.dart';
import 'package:anonymous_chat/screens/change_password/change_password.dart';

class SettingScreen extends StatelessWidget {
  SettingScreen(this._userData);

  final Map<String, dynamic> _userData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Setting')),
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
                color: Colors.grey[700],
              ),
            ),
            SizedBox(height: 10),
            Text(
              _userData['name'],
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 5),
            Text(
              _userData['email'],
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 30),
            Link(
              Icons.vpn_key,
              'Change Password',
              () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => ChangePasswordScreen(),
                ),
              ),
            ),
            Link(
              Icons.exit_to_app,
              'Logout',
              () => openDialogue(context),
            ),
          ],
        ),
      ),
    );
  }
}
