import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:anonymous_chat/services/auth/auth_exception.dart';

// This class will handle general auth purposes
// like login, register, loaduser
class AuthService {
  // Handler for logging in user
  static Future<AuthResultStatus> login({
    @required String email,
    @required String password,
  }) async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    FirebaseFirestore _firestore = FirebaseFirestore.instance;
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

        QuerySnapshot _userSnapshot = await _firestore
            .collection('users')
            .where('id', isEqualTo: _user.uid)
            .get();

        List<DocumentSnapshot> _userDocs = _userSnapshot.docs;

        _prefs.setString('name', _userDocs[0].get('name'));
        _prefs.setString('email', _userDocs[0].get('email'));
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
    FirebaseFirestore _firestore = FirebaseFirestore.instance;
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

        _firestore.collection('users').doc(_user.uid).set({
          'id': _user.uid,
          'name': name,
          'email': email,
        });

        _prefs.setString('name', name);
        _prefs.setString('email', email);
      }
    } catch (e) {
      _status = AuthExceptionHandler.handleException(e);
    }

    return _status;
  }

  // Handler for load logged in user
  static User loadUser() {
    User _user = FirebaseAuth.instance.currentUser;
    return _user;
  }
}
