class AuthExceptionHandler {
  static AuthResultStatus handleException(e) {
    AuthResultStatus _status;

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
      case 'email-already-in-use':
        _status = AuthResultStatus.emailAlreadyExists;
        break;
      default:
        _status = AuthResultStatus.undefined;
    }

    return _status;
  }

  static String generateErrorMessage(AuthResultStatus status) {
    String _message;

    switch (status) {
      case AuthResultStatus.invalidEmail:
        _message = 'Your entered email address is invalid.';
        break;
      case AuthResultStatus.wrongPassword:
        _message = 'Your password is wrong.';
        break;
      case AuthResultStatus.userNotFound:
        _message = 'User with this email is not registered.';
        break;
      case AuthResultStatus.userDisabled:
        _message = 'User with this email has been disabled.';
        break;
      case AuthResultStatus.tooManyRequests:
        _message = 'Too many requests. Try again later.';
        break;
      case AuthResultStatus.operationNotAllowed:
        _message = 'Signing in with Email and Password is not enabled.';
        break;
      case AuthResultStatus.emailAlreadyExists:
        _message = 'Account with this Email is already registered';
        break;
      default:
        _message = 'An undefined error occurred.';
    }

    return _message;
  }
}

enum AuthResultStatus {
  successful,
  emailAlreadyExists,
  wrongPassword,
  invalidEmail,
  userNotFound,
  userDisabled,
  operationNotAllowed,
  tooManyRequests,
  undefined,
}