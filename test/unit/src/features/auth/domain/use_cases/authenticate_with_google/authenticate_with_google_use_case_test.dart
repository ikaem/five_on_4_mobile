// call repo

// test that it should return normally

// TODO test later that it should throw when repo throws - dont test specific execptions, just make sure that it does not handle expectpions on its own

import 'package:five_on_4_mobile/src/features/auth/domain/repositories/auth/auth_repository.dart';
import 'package:five_on_4_mobile/src/features/auth/domain/use_cases/authenticate_with_google/authenticate_with_google_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  final authRepository = _MockAuthRepository();

  // tested class
  final authenticateWithGoogleUseCase = AuthenticateWithGoogleUseCase(
    authRepository: authRepository,
  );

  tearDown(() {
    reset(authRepository);
  });

  group(
    "$AuthenticateWithGoogleUseCase",
    () {
      // should return normally
      group(".call()", () {
        test(
          "given nothing in particular "
          "when call() is called"
          "then should return normally",
          () async {
            // setup
            when(() => authRepository.authenticateWithGoogle()).thenAnswer(
              (_) async {},
            );

            // Given

            // When / Then
            expect(
              () => authenticateWithGoogleUseCase(),
              returnsNormally,
            );
          },
        );
      });

      // should call auth repository
      test(
        "given nothing in particular "
        "when call() is called"
        "then should call AuthRepository.authenticateWithGoogle()",
        () async {
          // setup
          when(() => authRepository.authenticateWithGoogle()).thenAnswer(
            (_) async {},
          );

          // given

          // when
          await authenticateWithGoogleUseCase();

          // then
          verify(() => authRepository.authenticateWithGoogle()).called(1);

          // cleanup
        },
      );
    },
  );
}

class _MockAuthRepository extends Mock implements AuthRepository {}
