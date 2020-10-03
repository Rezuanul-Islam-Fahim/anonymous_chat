import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:anonymous_chat/screens/login/login.dart';
import 'package:anonymous_chat/screens/chat/chat.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize firebase
  await Firebase.initializeApp();

  // Main function for running app
  runApp(AnonymousChat());
}

class AnonymousChat extends StatelessWidget {
  final bool _isLoggedIn = !(FirebaseAuth.instance.currentUser == null);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Anonymous Chat',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blueGrey),
      home: _isLoggedIn ? ChatScreen() : LoginScreen(),
    );
  }
}
