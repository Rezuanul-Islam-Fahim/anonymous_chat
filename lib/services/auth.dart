import 'package:firebase_auth/firebase_auth.dart';

import 'auth_exception.dart';

class AuthService {
  static Future<AuthResultStatus> login({String email, String password}) async {
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
      print(e.code);
      _status = AuthExceptionHandler.handleException(e);
    }

    return _status;
  }
}
