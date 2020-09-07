import 'dart:async';

import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

import '../global.dart';
import '../components/login_register_button.dart';
import 'register.dart';
import 'chat.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _loginUser(BuildContext context) async {
    final UserCredential _user = await _auth.signInWithEmailAndPassword(
      email: _emailController.text,
      password: _passwordController.text,
    );

    Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => ChatScreen(_user),
    ));

    _emailController.clear();
    _passwordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
        padding: const EdgeInsets.only(top: 60, left: 15, right: 15),
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              child: Hero(
                tag: 'logo',
                child: Image.asset(
                  'assets/images/logo.png',
                  height: 150,
                  width: 150,
                ),
              ),
            ),
            Text(
              'Anonymous Chat',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: Colors.grey[800],
              ),
            ),
            SizedBox(height: 40),
            TextField(
              decoration: inputField(
                'Enter your E-mail',
                Icon(Icons.email_outlined),
              ),
              controller: _emailController,
            ),
            SizedBox(height: 20),
            TextField(
              decoration: inputField(
                'Enter your Password',
                Icon(Icons.lock_outlined),
              ),
              controller: _passwordController,
              obscureText: true,
            ),
            SizedBox(height: 20),
            LoginRegisterButton('Login', () => _loginUser(context)),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Don\'t have an account? ',
                  style: TextStyle(fontSize: 16),
                ),
                GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => RegisterScreen()),
                  ),
                  child: Text(
                    'Register Now',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
