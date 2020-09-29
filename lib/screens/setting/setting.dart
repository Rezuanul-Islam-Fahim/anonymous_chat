import 'package:flutter/material.dart';

import 'package:anonymous_chat/screens/setting/components/button.dart';
import 'package:anonymous_chat/screens/setting/components/alert_dialogue.dart';
import 'package:anonymous_chat/screens/change_password/change_password.dart';

class SettingScreen extends StatelessWidget {
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
            SizedBox(height: 20),
            Button(
              Icons.vpn_key,
              'Change Password',
              () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => ChangePasswordScreen(),
                ),
              ),
            ),
            Button(
              Icons.exit_to_app,
              'Log Out',
              () => openDialogue(context),
            ),
          ],
        ),
      ),
    );
  }
}
