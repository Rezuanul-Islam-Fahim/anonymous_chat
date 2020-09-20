import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static Future<void> login({String email, String password}) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();

    FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    if (!_prefs.containsKey('userEmail')) {
      _prefs.setString('userEmail', email);
      _prefs.setString('userPassword', password);
    }
  }
}
