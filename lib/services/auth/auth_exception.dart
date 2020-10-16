// Class for handling auth exceptions
class AuthExceptionHandler {
  // This handler will return auth process result
  static AuthResultStatus handleException(e) {
    AuthResultStatus _status;

    // Generate status
    switch (e.code) {
      case 'invalid-email':
        _status = AuthResultStatus.invalidEmail;
        break;
      case 'wrong-password':
        _status = AuthResultStatus.wrongPassword;
        break;
      case 'user-not-found':
        _status = AuthResultStatus.userNotFound;
        break;
      case 'user-disabled':
        _status = AuthResultStatus.userDisabled;
        break;
      case 'too-many-requests':
        _status = AuthResultStatus.tooManyRequests;
        break;
      case 'operation-not-allowed':
        _status = AuthResultStatus.operationNotAllowed;
        break;
      case 'weak-password':
        _status = AuthResultStatus.weekPassword;
        break;
      case 'email-already-in-use':
        _status = AuthResultStatus.emailAlreadyExists;
        break;
      default:
        _status = AuthResultStatus.undefined;
    }

    return _status;
  }

  // This handler will return auth error message
  static String generateErrorMessage(AuthResultStatus status) {
    String _message;

    // Generate error message
    switch (status) {
      case AuthResultStatus.invalidEmail:
        _message = 'Your entered email address is invalid';
        break;
      case AuthResultStatus.wrongPassword:
        _message = 'Your password is wrong';
        break;
      case AuthResultStatus.userNotFound:
        _message = 'User with this email is not registered';
        break;
      case AuthResultStatus.userDisabled:
        _message = 'User with this email has been disabled';
        break;
      case AuthResultStatus.tooManyRequests:
        _message = 'Too many requests. Try again later';
        break;
      case AuthResultStatus.operationNotAllowed:
        _message = 'Signing in with Email and Password is not enabled';
        break;
      case AuthResultStatus.weekPassword:
        _message =
            'Your password is weak. Password should be at least 6 characters';
        break;
      case AuthResultStatus.emailAlreadyExists:
        _message = 'Account with this Email is already registered';
        break;
      default:
        _message = 'An undefined error occurred';
    }

    return _message;
  }
}

// Auth result enums
enum AuthResultStatus {
  successful,
  emailAlreadyExists,
  wrongPassword,
  invalidEmail,
  userNotFound,
  userDisabled,
  operationNotAllowed,
  weekPassword,
  tooManyRequests,
  undefined,
}
