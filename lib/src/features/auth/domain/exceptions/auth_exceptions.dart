import 'package:five_on_4_mobile/src/features/core/domain/exceptions/exception_with_message.dart';

sealed class AuthException implements ExceptionWithMessage {
  const AuthException({
    required this.message,
  });

  @override
  final String message;

  @override
  String toString() {
    return "AuthException -> $message";
  }
}

class AuthCannotRetrieveGoogleAccountException extends AuthException {
  const AuthCannotRetrieveGoogleAccountException()
      : super(
          message: "Unable to retrieve account from Google Sign In",
        );
}

class AuthGoogleSignInIdTokenNullException extends AuthException {
  const AuthGoogleSignInIdTokenNullException()
      : super(
          message: "Google SignIn idToken is null",
        );
}

class AuthExceptionSignoutFailed extends AuthException {
  const AuthExceptionSignoutFailed()
      : super(
          message: "Failed to sign out",
        );
}

// TODO rename all exceptions to have AuthException prefix
class AuthExceptionFailedToAuthenticateWithGoogle extends AuthException {
  const AuthExceptionFailedToAuthenticateWithGoogle()
      : super(
          message: "Failed to authenticate with Google",
        );
}

class AuthNotLoggedInException extends AuthException {
  const AuthNotLoggedInException()
      : super(
          message: "User is not logged in",
        );
}

class AuthSomethingWentWrongException extends AuthException {
  const AuthSomethingWentWrongException({
    required String contextMessage,
  }) : super(
          message: "Something went wrong with authentication: $contextMessage",
        );
}

class AuthMultipleLocalAuthenticatedPlayersException extends AuthException {
  const AuthMultipleLocalAuthenticatedPlayersException()
      : super(
          message: "Multiple local authenticated players found",
        );
}
