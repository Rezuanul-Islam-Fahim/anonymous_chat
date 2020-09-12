import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'screens/login.dart';
import 'screens/chat.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final SharedPreferences _prefs = await SharedPreferences.getInstance();

  UserCredential _savedUser;
  String _savedEmail = _prefs.getString('userEmail');
  String _savedPassword = _prefs.getString('userPassword');

  if (_savedEmail != null) {
    _savedUser = await _auth.signInWithEmailAndPassword(
      email: _savedEmail,
      password: _savedPassword,
    );
  }

  runApp(AnonymousChat(user: _savedUser));
}

class AnonymousChat extends StatelessWidget {
  final UserCredential user;

  AnonymousChat({this.user});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Anonymous Chat',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blueGrey),
      home: user != null ? ChatScreen(user) : LoginScreen(),
    );
  }
}
