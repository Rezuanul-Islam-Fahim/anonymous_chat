import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';

import 'screens/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(AnonymousChat());
}

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
