import 'package:flutter/material.dart';

import '../global.dart';

class LoginScreen extends StatelessWidget {
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
              decoration: inputField('Enter your E-mail'),
            ),
            SizedBox(height: 20),
            TextField(
              decoration: inputField('Enter your Password'),
            ),
            SizedBox(height: 20),
            Container(
              width: double.infinity,
              child: RaisedButton(
                child: Text('Login', style: TextStyle(fontSize: 16)),
                padding: EdgeInsets.all(16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
                onPressed: () {},
              ),
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Don\'t have an account? ',
                  style: TextStyle(fontSize: 16),
                ),
                GestureDetector(
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
