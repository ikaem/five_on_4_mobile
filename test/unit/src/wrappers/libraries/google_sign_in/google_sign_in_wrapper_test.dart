import 'package:five_on_4_mobile/src/features/auth/domain/exceptions/auth_exceptions.dart';
import 'package:five_on_4_mobile/src/wrappers/libraries/google_sign_in/google_sign_in_wrapper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../utils/matchers/throws_exception_with_message.dart';

void main() {
  final googleSignIn = _MockGoogleSignIn();

// tested class
  final googleSignInWrapper = GoogleSignInWrapper(googleSignIn: googleSignIn);

  tearDown(() {
    reset(googleSignIn);
  });

  group("$GoogleSignInWrapper", () {
    group(".signInAndGetIdToken", () {
      // should throw when unable to retrieve account from Google Sign In
      test(
        "given GoogleSignIn.signIn() returns null"
        "when .signInAndGetIdToken() is called"
        "then should throw expected exception",
        () async {
          // setup

          // given
          when(() => googleSignIn.signIn()).thenAnswer((_) async => null);

          // when / then
          // final actual = googleSignInWrapper.signInAndGetIdToken();
          expect(
            () => googleSignInWrapper.signInAndGetIdToken(),
            throwsExceptionWithMessage<
                AuthCannotRetrieveGoogleAccountException>(
              "Unable to retrieve account from Google Sign In",
            ),
          );

          // cleanup
        },
      );

      // should throw when unable to retrieve idToken from Google Sign In
      test(
        "given retrieved GoogleSignInAuthentication has null iToken"
        "when .signInAndGetIdToken() is called"
        "then should throw expected exception",
        () async {
          // setup
          final account = _MockGoogleSignInAccount();
          final auth = _MockGoogleSignInAuthentication();

          when(() => googleSignIn.signIn()).thenAnswer((_) async => account);

          // given
          when(() => account.authentication).thenAnswer((_) async => auth);
          when(() => auth.idToken).thenReturn(null);

          // when / then
          expect(
            () => googleSignInWrapper.signInAndGetIdToken(),
            throwsExceptionWithMessage<AuthGoogleSignInIdTokenNullException>(
              "Google SignIn idToken is null",
            ),
          );

          // cleanup
        },
      );

      test(
        "given retrieved GoogleSignInAuthentication has idToken"
        "when .signInAndGetIdToken() is called"
        "then should return expected idToken",
        () async {
          // setup
          const idToken = "idToken";

          final account = _MockGoogleSignInAccount();
          final auth = _MockGoogleSignInAuthentication();

          when(() => googleSignIn.signIn()).thenAnswer((_) async => account);

          // given
          when(() => account.authentication).thenAnswer((_) async => auth);
          when(() => auth.idToken).thenReturn(idToken);

          // when
          final idTokenResponse =
              await googleSignInWrapper.signInAndGetIdToken();

          // then
          expect(idTokenResponse, idToken);

          // cleanup
        },
      );

      // should return idToken when able to retrieve idToken from Google Sign In
    });
  });
}

class _MockGoogleSignIn extends Mock implements GoogleSignIn {}

class _MockGoogleSignInAccount extends Mock implements GoogleSignInAccount {}

class _MockGoogleSignInAuthentication extends Mock
    implements GoogleSignInAuthentication {}
