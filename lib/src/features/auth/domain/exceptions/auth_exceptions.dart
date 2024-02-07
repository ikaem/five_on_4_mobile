sealed class AuthException implements Exception {
  const AuthException({
    required this.message,
  });

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
