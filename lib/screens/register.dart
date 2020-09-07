import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

import '../global.dart';
import '../components/login_register_button.dart';
import 'chat.dart';

class RegisterScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _registerUser(BuildContext context) async {
    final UserCredential _user = await _auth.createUserWithEmailAndPassword(
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
      body: Stack(
        children: <Widget>[
          Padding(
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
                  decoration: inputField(
                    'Name',
                    Icon(Icons.account_circle_outlined),
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  decoration: inputField(
                    'E-mail',
                    Icon(Icons.email_outlined),
                  ),
                  controller: _emailController,
                ),
                SizedBox(height: 20),
                TextField(
                  decoration: inputField(
                    'Password',
                    Icon(Icons.lock_outlined),
                  ),
                  controller: _passwordController,
                  obscureText: true,
                ),
                SizedBox(height: 20),
                LoginRegisterButton(
                  'Register Now',
                  () => _registerUser(context),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 35, left: 15),
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              iconSize: 30,
              color: Colors.grey[700],
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
        ],
      ),
    );
  }
}
