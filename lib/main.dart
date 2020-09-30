import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:anonymous_chat/services/auth/auth.dart';
import 'package:anonymous_chat/screens/login/login.dart';
import 'package:anonymous_chat/screens/chat/chat.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize firebase
  await Firebase.initializeApp();

  // Load user credentials from local storage
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  String _userEmail = _prefs.getString('userEmail');
  String _userPassword = _prefs.getString('userPassword');

  // Login previously logged user, if user credentials
  // found on local storage
  if (_prefs.containsKey('userEmail')) {
    AuthService.login(
      email: _userEmail,
      password: _userPassword,
    );
  }

  // Main function for run app
  runApp(AnonymousChat(email: _userEmail));
}

class AnonymousChat extends StatelessWidget {
  AnonymousChat({this.email});

  final String email;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Anonymous Chat',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blueGrey),
      home: email != null ? ChatScreen() : LoginScreen(),
    );
  }
}
