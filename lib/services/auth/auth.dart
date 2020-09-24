import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:anonymous_chat/services/auth/auth_exception.dart';

class AuthService {
  static Future<AuthResultStatus> login({
    @required String email,
    @required String password,
  }) async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    AuthResultStatus _status;

    try {
      UserCredential _user = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (_user.user != null) {
        _status = AuthResultStatus.successful;
      }
    } catch (e) {
      _status = AuthExceptionHandler.handleException(e);
    }

    return _status;
  }

  static Future<AuthResultStatus> register({
    @required String name,
    @required String email,
    @required String password,
  }) async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    AuthResultStatus _status;

    try {
      UserCredential _user = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (_user.user != null) {
        _status = AuthResultStatus.successful;

        FirebaseFirestore _firestore = FirebaseFirestore.instance;
        _firestore.collection('users').doc(_user.user.uid).set({
          'name': name,
        });
      }
    } catch (e) {
      _status = AuthExceptionHandler.handleException(e);
    }

    return _status;
  }
}
