import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

import '../global.dart';
import 'chat.dart';

class RegisterScreen extends StatelessWidget {
  String username;
  String email;
  String password;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _registerUser(BuildContext context) async {
    final UserCredential _user = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => ChatScreen(_user),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              child: Image.asset(
                'assets/images/logo.png',
                height: 150,
                width: 150,
              ),
            ),
            SizedBox(height: 30),
            TextField(
              decoration: inputField('Name'),
            ),
            SizedBox(height: 20),
            TextField(
              decoration: inputField('E-mail'),
              onChanged: (value) => email = value,
            ),
            SizedBox(height: 20),
            TextField(
              decoration: inputField('Password'),
              onChanged: (value) => password = value,
              obscureText: true,
            ),
            SizedBox(height: 20),
            Container(
              width: double.infinity,
              child: RaisedButton(
                child: Text('Register', style: TextStyle(fontSize: 16)),
                padding: EdgeInsets.all(16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
                onPressed: () => _registerUser(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
