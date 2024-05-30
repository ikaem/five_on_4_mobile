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
