import 'package:five_on_4_mobile/src/features/auth/domain/repositories/auth/auth_repository.dart';
import 'package:five_on_4_mobile/src/features/auth/domain/use_cases/sign_out/sign_out_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  final authRepository = _MockAuthRepository();

  // tested class
  final useCase = SignOutUseCase(
    authRepository: authRepository,
  );

  tearDown(() {
    reset(authRepository);
  });

  group("$SignOutUseCase", () {
    group(".call()", () {
      test(
        "given nothing in particular"
        "when .call() is called"
        "then should call AuthRepository.signOut()",
        () async {
          // setup
          when(() => authRepository.signOut()).thenAnswer(
            (_) async {
              return;
            },
          );

          // given

          // when
          await useCase();

          // then
          verify(() => authRepository.signOut()).called(1);

          // cleanup
        },
      );
    });
  });
}

class _MockAuthRepository extends Mock implements AuthRepository {}
