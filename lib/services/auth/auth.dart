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
    FirebaseAuth _auth = FirebaseAuth.instance;
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    AuthResultStatus _status;

    try {
      UserCredential _result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User _user = _result.user;

      if (_user != null) {
        _status = AuthResultStatus.successful;

        // Load user data from database
        Map<String, dynamic> _userData = await DatabaseService.userId(
          _user.uid,
        ).getUserData();

        // Save user credentials on local storage
        await _prefs.setString('name', _userData['name']);
        await _prefs.setString('email', _userData['email']);
        await _prefs.setString('password', password);
      }
    } catch (e) {
      _status = AuthExceptionHandler.handleException(e);
    }

    return _status;
  }

  // Handler for registering new user
  static Future<AuthResultStatus> register({
    @required String name,
    @required String email,
    @required String password,
  }) async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    AuthResultStatus _status;

    try {
      UserCredential _result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User _user = _result.user;

      if (_user != null) {
        _status = AuthResultStatus.successful;

        // Store user data to database when register is successful
        DatabaseService.userId(_user.uid).storeUser({
          'id': _user.uid,
          'name': name,
          'email': email,
        });

        // Store user credentials to local storage
        await _prefs.setString('name', name);
        await _prefs.setString('email', email);
        await _prefs.setString('password', password);
      }
    } catch (e) {
      _status = AuthExceptionHandler.handleException(e);
    }

    return _status;
  }

  // Handler for logout user
  static Future<void> logOut() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    FirebaseAuth _auth = FirebaseAuth.instance;

    // Clear credentials from local storage
    _prefs.clear();

    // Logout
    _auth.signOut();
  }

  // Change-password handler
  static Future<AuthResultStatus> changePassword({
    @required String newPassword,
  }) async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    AuthResultStatus _status = AuthResultStatus.successful;

    try {
      // Do recent-login operation for changing-password
      UserCredential _result = await _auth.signInWithEmailAndPassword(
        email: _prefs.getString('email'),
        password: _prefs.getString('password'),
      );
      User _user = _result.user;

      // Update password
      await _user.updatePassword(newPassword);
    } catch (e) {
      _status = AuthExceptionHandler.handleException(e);
    }

    if (_status == AuthResultStatus.successful) {
      logOut();
    }

    return _status;
  }
}
