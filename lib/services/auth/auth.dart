import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:anonymous_chat/services/database.dart';
import 'package:anonymous_chat/services/auth/auth_exception.dart';

// This class will handle general auth purposes like
// login, register, change-password, logout
class AuthService {
  // Handler for logging in user
  static Future<AuthResultStatus> login({
    @required String email,
    @required String password,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    AuthResultStatus status;

    try {
      UserCredential result = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User user = result.user;

      if (user != null) {
        status = AuthResultStatus.successful;

        // Load user data from database
        Map<String, dynamic> userData = await DatabaseService.userId(
          user.uid,
        ).getUserData();

        // Save user credentials on local storage
        await prefs.setString('name', userData['name']);
        await prefs.setString('email', userData['email']);
        await prefs.setString('password', password);
      }
    } catch (e) {
      status = AuthExceptionHandler.handleException(e);
    }

    return status;
  }

  // Handler for registering new user
  static Future<AuthResultStatus> register({
    @required String name,
    @required String email,
    @required String password,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    AuthResultStatus status;

    try {
      UserCredential result = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User user = result.user;

      if (user != null) {
        status = AuthResultStatus.successful;

        // Store user data to database when registering is successful
        DatabaseService.userId(user.uid).storeUser({
          'id': user.uid,
          'name': name,
          'email': email,
        });

        // Store user credentials to local storage
        await prefs.setString('name', name);
        await prefs.setString('email', email);
        await prefs.setString('password', password);
      }
    } catch (e) {
      status = AuthExceptionHandler.handleException(e);
    }

    return status;
  }

  // Check if an user is logged in or not
  static bool get isLoggedIn {
    if (FirebaseAuth.instance.currentUser != null) {
      return true;
    }
    return false;
  }

  // Handler for logout user
  static Future<void> logOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    FirebaseAuth auth = FirebaseAuth.instance;

    // Clear credentials from local storage
    prefs.clear();

    // Logout
    auth.signOut();
  }

  // Change-password handler
  static Future<AuthResultStatus> changePassword({
    @required String newPassword,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    AuthResultStatus status = AuthResultStatus.successful;

    try {
      // Do recent-login operation for changing-password
      UserCredential result = await auth.signInWithEmailAndPassword(
        email: prefs.getString('email'),
        password: prefs.getString('password'),
      );
      User user = result.user;

      // Update password
      await user.updatePassword(newPassword);
    } catch (e) {
      status = AuthExceptionHandler.handleException(e);
    }

    if (status == AuthResultStatus.successful) {
      logOut();
    }

    return status;
  }
}
