import 'package:flutter/material.dart';

// Header widget for login and register screen
class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size _deviceSize = MediaQuery.of(context).size;

    return Column(
      children: <Widget>[
        SizedBox(height: _deviceSize.width > 800 ? 20 : 70),
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
      ],
    );
  }
}
