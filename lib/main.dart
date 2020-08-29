import 'package:flutter/material.dart';

import 'screens/login.dart';

void main() => runApp(AnonymousChat());

class AnonymousChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Anonymous Chat',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blueGrey),
      home: LoginScreen(),
    );
  }
}
