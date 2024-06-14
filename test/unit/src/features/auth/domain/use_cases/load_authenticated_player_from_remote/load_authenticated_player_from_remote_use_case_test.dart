import 'package:five_on_4_mobile/src/features/auth/domain/repositories/auth/auth_repository.dart';
import 'package:five_on_4_mobile/src/features/auth/domain/use_cases/get_authenticated_player_model_stream/get_authenticated_player_model_stream_use_case.dart';
import 'package:five_on_4_mobile/src/features/auth/domain/use_cases/load_authenticated_player_from_remote/load_authenticated_player_from_remote_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  final authRepository = _MockAuthRepository();

  // tested class
  final useCase = LoadAuthenticatedPlayerFromRemoteUseCase(
    authRepository: authRepository,
  );

  tearDown(() {
    reset(authRepository);
  });

  group("$LoadAuthenticatedPlayerFromRemoteUseCase", () {
    group(".call()", () {
      test(
        "given nothing in particular"
        "when .call() is called"
        "then should call AuthRepository.getAuthenticatedPlayerModelStream()",
        () async {
          // setup
          when(() => authRepository.loadAuthenticatedPlayerFromRemote())
              .thenAnswer(
            (_) async {
              return;
            },
          );

          // given

          // when
          await useCase();

          // then
          verify(() => authRepository.loadAuthenticatedPlayerFromRemote())
              .called(1);

          // cleanup
        },
      );
    });
  });
}

class _MockAuthRepository extends Mock implements AuthRepository {}
