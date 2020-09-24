import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:anonymous_chat/services/auth.dart';
import 'package:anonymous_chat/screens/login/login.dart';
import 'package:anonymous_chat/screens/chat/chat.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  SharedPreferences _prefs = await SharedPreferences.getInstance();
  String _userEmail = _prefs.getString('userEmail');
  String _userPassword = _prefs.getString('userPassword');

  if (_prefs.containsKey('userEmail')) {
    AuthService.login(
      email: _userEmail,
      password: _userPassword,
    );
  }

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
