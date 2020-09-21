class AuthExceptionHandler {
  static AuthResultStatus handleException(e) {
    AuthResultStatus status;

    switch (e.code) {
      case 'invalid-email':
        status = AuthResultStatus.invalidEmail;
        break;
      case 'wrong-password':
        status = AuthResultStatus.wrongPassword;
        break;
      case 'user-not-found':
        status = AuthResultStatus.userNotFound;
        break;
      case 'user-disabled':
        status = AuthResultStatus.userDisabled;
        break;
      case 'too-many-requests':
        status = AuthResultStatus.tooManyRequests;
        break;
      case 'operation-not-allowed':
        status = AuthResultStatus.operationNotAllowed;
        break;
      case 'email-already-in-use':
        status = AuthResultStatus.emailAlreadyExists;
        break;
      default:
        status = AuthResultStatus.undefined;
    }

    return status;
  }

  static String generateErrorMessage(AuthResultStatus status) {
    String message;

    switch (status) {
      case AuthResultStatus.invalidEmail:
        message = 'Your entered email address is invalid.';
        break;
      case AuthResultStatus.wrongPassword:
        message = 'Your password is wrong.';
        break;
      case AuthResultStatus.userNotFound:
        message = 'User with this email doesn\'t exist.';
        break;
      case AuthResultStatus.userDisabled:
        message = 'User with this email has been disabled.';
        break;
      case AuthResultStatus.tooManyRequests:
        message = 'Too many requests. Try again later.';
        break;
      case AuthResultStatus.operationNotAllowed:
        message = 'Signing in with Email and Password is not enabled.';
        break;
      case AuthResultStatus.emailAlreadyExists:
        message = 'Account with this Email is already registered';
        break;
      default:
        message = 'An undefined error occurred.';
    }

    return message;
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
