import 'package:five_on_4_mobile/src/features/core/domain/exceptions/exception_with_message.dart';

sealed class MatchException implements ExceptionWithMessage {
  const MatchException({
    required this.message,
  });

  @override
  final String message;

  @override
  String toString() {
    return "MatchException -> $message";
  }
}

class MatchNotFoundException extends MatchException {
  const MatchNotFoundException({
    required String message,
  }) : super(
          message: message,
        );
}
