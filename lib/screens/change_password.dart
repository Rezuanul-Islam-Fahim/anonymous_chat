import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../global.dart';
import '../components/login_register_button.dart';

class ChangePasswordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Change Password'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            TextField(
              decoration: inputField(
                'Enter Old Password',
                Icon(Icons.vpn_key_outlined),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              decoration: inputField(
                'Enter New Password',
                Icon(Icons.vpn_key_outlined),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              decoration: inputField(
                'Confirm Password',
                Icon(Icons.vpn_key_outlined),
              ),
            ),
            SizedBox(height: 20),
            LoginRegisterButton('Change Password', () {
              final _auth = FirebaseAuth.instance;
              final User _user = _auth.currentUser;
              print(_user.email);
            }),
          ],
        ),
      ),
    );
  }
}
