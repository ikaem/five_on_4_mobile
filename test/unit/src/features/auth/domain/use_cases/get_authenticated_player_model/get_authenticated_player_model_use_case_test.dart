import 'package:five_on_4_mobile/src/features/auth/domain/models/authenticated_player/authenticated_player_model.dart';
import 'package:five_on_4_mobile/src/features/auth/domain/repositories/auth/auth_repository.dart';
import 'package:five_on_4_mobile/src/features/auth/domain/use_cases/get_authenticated_player_model/get_authenticated_player_model_use_case.dart';
import 'package:five_on_4_mobile/src/features/auth/domain/values/anthenticated_player_local_entity_value.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../../../utils/data/test_entities.dart';

void main() {
  final authRepository = _MockAuthRepository();

// tested class
  final useCase = GetAuthenticatedPlayerModelUseCase(
    authRepository: authRepository,
  );

  tearDown(() {
    reset(authRepository);
  });

  group("$GetAuthenticatedPlayerModelUseCase", () {
    group(".call()", () {
// should return auth if it exists
      test(
        "given authenticated player exists"
        "when .call() is called"
        "then should return expected value",
        () async {
          // setup
          final authenticatedPlayerLocalEntityValue =
              generateTestAuthenticatedPlayerLocalEntityCompanions(count: 1)
                  .map((entity) {
            return AuthenticatedPlayerLocalEntityValue(
              playerId: entity.playerId.value,
              playerName: entity.playerName.value,
              playerNickname: entity.playerNickname.value,
            );
          }).first;

          // given
          when(() => authRepository.getAuthenticatedPlayerModel())
              .thenAnswer((_) async {
            return AuthenticatedPlayerModel(
              playerId: authenticatedPlayerLocalEntityValue.playerId,
              playerName: authenticatedPlayerLocalEntityValue.playerName,
              playerNickname:
                  authenticatedPlayerLocalEntityValue.playerNickname,
            );
          });

          // when
          final result = await useCase();

          // then
          final expected = AuthenticatedPlayerModel(
            playerId: authenticatedPlayerLocalEntityValue.playerId,
            playerName: authenticatedPlayerLocalEntityValue.playerName,
            playerNickname: authenticatedPlayerLocalEntityValue.playerNickname,
          );

          expect(result, equals(expected));

          // cleanup
        },
      );

// should return null if it does not exist

      test(
        "given authenticated player does not exist"
        "when .call() is called"
        "then should return null",
        () async {
          // setup
          when(() => authRepository.getAuthenticatedPlayerModel())
              .thenAnswer((_) async {
            return null;
          });

          // given

          // when
          final result = await useCase();

          // then
          expect(result, isNull);

          // cleanup
        },
      );
    });
  });
}

class _MockAuthRepository extends Mock implements AuthRepository {}
