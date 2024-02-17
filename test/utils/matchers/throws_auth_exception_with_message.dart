import 'package:five_on_4_mobile/src/features/auth/domain/exceptions/auth_exceptions.dart';
import 'package:flutter_test/flutter_test.dart';

// Matcher throwsAuthExceptionWithMessage<T extends AuthException>(
//   String message,
// ) {
//   // return _AuthExceptionWithMessageMatcher<T>(message);
//   return Throws(wrapMatcher(_AuthExceptionWithMessageMatcher(message)));
// }

// class _AuthExceptionWithMessageMatcher<T extends AuthException>
//     extends Matcher {
//   const _AuthExceptionWithMessageMatcher(this.message);
//   final String message;

//   @override
//   Description describe(Description description) {
//     return description.add('$AuthException with message: ');
//   }

//   @override
//   bool matches(dynamic item, Map matchState) {
//     if (item is! AuthException) return false;
//     if (item is! T) return false;
//     if (item.message != message) return false;

//     return true;
//   }
// }
