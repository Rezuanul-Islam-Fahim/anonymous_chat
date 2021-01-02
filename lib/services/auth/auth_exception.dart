// Class for handling auth exceptions
class AuthExceptionHandler {
  // This handler will return auth process result
  static AuthResultStatus handleException(e) {
    AuthResultStatus status;

    // Generate status
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
      case 'weak-password':
        status = AuthResultStatus.weekPassword;
        break;
      case 'email-already-in-use':
        status = AuthResultStatus.emailAlreadyExists;
        break;
      default:
        status = AuthResultStatus.undefined;
    }

    return status;
  }

  // This handler will return auth error message
  static String generateErrorMessage(AuthResultStatus status) {
    String message;

    // Generate error message
    switch (status) {
      case AuthResultStatus.invalidEmail:
        message = 'Your entered email address is invalid';
        break;
      case AuthResultStatus.wrongPassword:
        message = 'Your password is wrong';
        break;
      case AuthResultStatus.userNotFound:
        message = 'User with this email is not registered';
        break;
      case AuthResultStatus.userDisabled:
        message = 'User with this email has been disabled';
        break;
      case AuthResultStatus.tooManyRequests:
        message = 'Too many requests. Try again later';
        break;
      case AuthResultStatus.operationNotAllowed:
        message = 'Signing in with email and password is not enabled';
        break;
      case AuthResultStatus.weekPassword:
        message =
            'Your password is weak. Password should be at least 6 characters';
        break;
      case AuthResultStatus.emailAlreadyExists:
        message = 'Account with this email is already registered';
        break;
      default:
        message = 'An undefined error occurred';
    }

    return message;
  }
}

// Auth status enums
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
