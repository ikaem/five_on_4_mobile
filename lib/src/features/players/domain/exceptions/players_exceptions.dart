import 'package:five_on_4_mobile/src/features/core/domain/exceptions/exception_with_message.dart';

sealed class PlayersExceptions implements ExceptionWithMessage {
  const PlayersExceptions({
    required this.message,
  });

  @override
  final String message;

  @override
  String toString() {
    return "PlayersException -> $message";
  }
}

class PlayersExceptionPlayerNotFound extends PlayersExceptions {
  const PlayersExceptionPlayerNotFound({
    required String message,
  }) : super(
          message: message,
        );
}
