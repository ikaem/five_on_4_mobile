import 'dart:async';

import 'package:five_on_4_mobile/src/features/auth/domain/exceptions/auth_exceptions.dart';
import 'package:five_on_4_mobile/src/features/auth/domain/models/authenticated_player/authenticated_player_model.dart';
import 'package:five_on_4_mobile/src/features/auth/domain/repositories/auth/auth_repository.dart';
import 'package:five_on_4_mobile/src/features/auth/domain/use_cases/get_authenticated_player_model_stream/get_authenticated_player_model_stream_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  final authRepository = _MockAuthRepository();

  final useCase = GetAuthenticatedPlayerModelStreamUseCase(
    authRepository: authRepository,
  );

  tearDown(() {
    reset(authRepository);
  });

  group("$GetAuthenticatedPlayerModelStreamUseCase", () {
    group(
      ".call()",
      () {
        test(
          "given a stream of AuthenticatedPlayerModel"
          "when listen to the stream"
          "then should emit expected events",
          () async {
            // setup
            const model = AuthenticatedPlayerModel(
              playerId: 1,
              playerName: "playerName",
              playerNickname: "playerNickname",
            );

            final streamController =
                StreamController<AuthenticatedPlayerModel?>();
            when(() => authRepository.getAuthenticatedPlayerModelStream())
                .thenAnswer(
              (_) {
                return streamController.stream;
              },
            );

            // given
            final stream = useCase();

            // then
            expectLater(
              stream,
              emitsInOrder([
                null,
                model,
                emitsError(isA<AuthMultipleLocalAuthenticatedPlayersException>()
                    .having(
                  (exception) => exception.message,
                  "message",
                  "Multiple local authenticated players found",
                ))
              ]),
            );

            // when
            streamController.add(null);
            streamController.add(model);
            streamController.addError(
              const AuthMultipleLocalAuthenticatedPlayersException(),
            );

            // cleanup
          },
        );
      },
    );
  });
}

class _MockAuthRepository extends Mock implements AuthRepository {}
