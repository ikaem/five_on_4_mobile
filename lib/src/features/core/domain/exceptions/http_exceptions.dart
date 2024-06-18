import 'package:five_on_4_mobile/src/features/core/domain/exceptions/exception_with_message.dart';

sealed class HttpException implements ExceptionWithMessage {
  const HttpException({
    required this.message,
  });

  @override
  final String message;

  @override
  String toString() {
    return "HttpException -> $message";
  }
}

class HttpRequestException extends HttpException {
  const HttpRequestException({
    required String contextMessage,
  }) : super(
          message: "Request failed: $contextMessage",
        );
}

class HttpNoResponseDataException extends HttpException {
  const HttpNoResponseDataException({
    required String contextMessage,
  }) : super(
          message: "No response data for request: $contextMessage",
        );
}
