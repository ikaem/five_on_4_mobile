import 'package:five_on_4_mobile/src/features/core/domain/exceptions/exception_with_message.dart';
import 'package:flutter_test/flutter_test.dart';

// TODO reuse this possibly for throws auth exception with message
Matcher throwsExceptionWithMessage<T extends ExceptionWithMessage>(
  String message,
) {
  return Throws(wrapMatcher(_ExceptionWithMessageMatcher(message)));
}

// matcher class - this is where the magic happens
class _ExceptionWithMessageMatcher<T extends ExceptionWithMessage>
    extends Matcher {
  const _ExceptionWithMessageMatcher(this.message);
  final String message;

  @override
  Description describe(Description description) {
    return description.add('$ExceptionWithMessage: ');
  }

  @override
  bool matches(dynamic item, Map matchState) {
    if (item is! ExceptionWithMessage) return false;
    if (item is! T) return false;
    if (item.message != message) return false;

    return true;
  }
}
