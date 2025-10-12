import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:anonymous_chat/services/auth/auth.dart';
import 'package:anonymous_chat/theme.dart';
import 'package:anonymous_chat/screens/login/login.dart';
import 'package:anonymous_chat/screens/chat/chat.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize firebase before running app
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Main function for running the app
  runApp(AnonymousChat());
}

class AnonymousChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Anonymous Chat',
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      home: AuthService.isLoggedIn ? ChatScreen() : LoginScreen(),
    );
  }
}
