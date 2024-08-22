import 'package:five_on_4_mobile/src/features/core/domain/exceptions/exception_with_message.dart';

// TODO this should be renamed to MatchesException
sealed class MatchesException implements ExceptionWithMessage {
  const MatchesException({
    required this.message,
  });

  @override
  final String message;

  @override
  String toString() {
    return "MatchException -> $message";
  }
}

class MatchesExceptionMatchFailedToCreate extends MatchesException {
  const MatchesExceptionMatchFailedToCreate()
      : super(
          // TODO maybe it will be ok to pass some custom message - we will see
          message: "Failed to create match",
        );
}

/* TODO rename all exceptions */

// TODO remove end Exception from this one in name
class MatchesExceptionMatchNotFoundException extends MatchesException {
  const MatchesExceptionMatchNotFoundException({
    required String message,
  }) : super(
          message: message,
        );
}
