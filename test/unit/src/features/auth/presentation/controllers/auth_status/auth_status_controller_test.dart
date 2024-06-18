import 'dart:async';

import 'package:five_on_4_mobile/src/features/auth/domain/models/authenticated_player/authenticated_player_model.dart';
import 'package:five_on_4_mobile/src/features/auth/domain/use_cases/get_authenticated_player_model_stream/get_authenticated_player_model_stream_use_case.dart';
import 'package:five_on_4_mobile/src/features/auth/domain/use_cases/load_authenticated_player_from_remote/load_authenticated_player_from_remote_use_case.dart';
import 'package:five_on_4_mobile/src/features/auth/presentation/controllers/auth_status/auth_status_controller.dart';
import 'package:five_on_4_mobile/src/wrappers/libraries/get_it/get_it_wrapper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  final getAuthenticatedPlayerModelStreamUseCase =
      _MockGetAuthenticatedPlayerModelStreamUseCase();
  final loadAuthenticatedPlayerFromRemoteUseCase =
      _MockLoadAuthenticatedPlayerFromRemoteUseCase();

// TODO missing tests for checking behavior with loadAuthenticatedPlayerFromRemoteUseCase

  setUpAll(() {
    // TODO will need to override getit to return a mock
    getIt.registerSingleton<GetAuthenticatedPlayerModelStreamUseCase>(
      getAuthenticatedPlayerModelStreamUseCase,
    );
    getIt.registerSingleton<LoadAuthenticatedPlayerFromRemoteUseCase>(
      loadAuthenticatedPlayerFromRemoteUseCase,
    );
  });

  tearDown(() {
    reset(getAuthenticatedPlayerModelStreamUseCase);
    reset(loadAuthenticatedPlayerFromRemoteUseCase);
  });

  group(
    "$AuthStatusController",
    () {
      group(
        ".isLoggedIn",
        () {
          test(
            "given the class"
            "when it is initialized"
            "then should have .isLoggedIn set to false",
            () async {
              // setup
              final streamController =
                  StreamController<AuthenticatedPlayerModel?>();
              when(() => getAuthenticatedPlayerModelStreamUseCase())
                  .thenAnswer((_) => streamController.stream);
              when(() => loadAuthenticatedPlayerFromRemoteUseCase())
                  .thenAnswer((_) async {});

              // given

              // when
              // final controller = AuthStatusController(
              //   getAuthenticatedPlayerModelStreamUseCase:
              //       getAuthenticatedPlayerModelStreamUseCase,
              // );
              final controller = AuthStatusController();

              // then
              expect(controller.isLoggedIn, false);

              // cleanup
            },
          );

          test(
            "given valid data emited from AuthenticatedPlayerModel stream"
            "when data is consumed"
            "then should have .isLoggedIn set to true",
            () async {
              // setup
              final streamController =
                  StreamController<AuthenticatedPlayerModel?>();
              when(() => getAuthenticatedPlayerModelStreamUseCase())
                  .thenAnswer((_) => streamController.stream);
              when(() => loadAuthenticatedPlayerFromRemoteUseCase())
                  .thenAnswer((_) async {});

              // final controller = AuthStatusController(
              //   getAuthenticatedPlayerModelStreamUseCase:
              //       getAuthenticatedPlayerModelStreamUseCase,
              // );

              final controller = AuthStatusController();

              // given
              streamController.add(const AuthenticatedPlayerModel(
                playerId: 1,
                playerName: "playerName",
                playerNickname: "playerNickname",
              ));
              await Future.delayed(Duration.zero);

              // when

              // then
              expect(controller.isLoggedIn, true);

              // cleanup
            },
          );

          test(
            "given error data emited from AuthenticatedPlayerModel stream"
            "when data is consumed"
            "then should have .isLoggedIn set to false",
            () async {
              // setup
              final streamController =
                  StreamController<AuthenticatedPlayerModel?>();
              when(() => getAuthenticatedPlayerModelStreamUseCase())
                  .thenAnswer((_) => streamController.stream);
              when(() => loadAuthenticatedPlayerFromRemoteUseCase())
                  .thenAnswer((_) async {});

              // final controller = AuthStatusController(
              //   getAuthenticatedPlayerModelStreamUseCase:
              //       getAuthenticatedPlayerModelStreamUseCase,
              // );
              final controller = AuthStatusController();

              // given
              streamController.addError(Exception());
              await Future.delayed(Duration.zero);

              // when

              // then
              expect(controller.isLoggedIn, false);

              // cleanup
            },
          );
        },
      );

      group(
        ".isError",
        () {
          test(
            "given the class"
            "when it is initialized"
            "then should have .isError set to false",
            () async {
              // setup
              final streamController =
                  StreamController<AuthenticatedPlayerModel?>();
              when(() => getAuthenticatedPlayerModelStreamUseCase())
                  .thenAnswer((_) => streamController.stream);
              when(() => loadAuthenticatedPlayerFromRemoteUseCase())
                  .thenAnswer((_) async {});

              // given

              // when
              final controller = AuthStatusController();

              // then
              expect(controller.isError, false);

              // cleanup
            },
          );

          test(
            "given error data emited from AuthenticatedPlayerModel stream"
            "when data is consumed"
            "then should have .isError set to true",
            () async {
              // setup
              final streamController =
                  StreamController<AuthenticatedPlayerModel?>();
              when(() => getAuthenticatedPlayerModelStreamUseCase())
                  .thenAnswer((_) => streamController.stream);
              when(() => loadAuthenticatedPlayerFromRemoteUseCase()).thenAnswer(
                (_) async {},
              );

              // final controller = AuthStatusController(
              //   getAuthenticatedPlayerModelStreamUseCase:
              //       getAuthenticatedPlayerModelStreamUseCase,
              // );
              final controller = AuthStatusController();

              // given
              streamController.addError(Exception());
              await Future.delayed(Duration.zero);

              // when

              // then
              expect(controller.isError, true);

              // cleanup
            },
          );

          test(
            "given valid data emited from AuthenticatedPlayerModel stream"
            "when data is consumed"
            "then should have .isError set to false",
            () async {
              // setup
              final streamController =
                  StreamController<AuthenticatedPlayerModel?>();
              when(() => getAuthenticatedPlayerModelStreamUseCase())
                  .thenAnswer((_) => streamController.stream);
              when(() => loadAuthenticatedPlayerFromRemoteUseCase()).thenAnswer(
                (_) async {},
              );

              // final controller = AuthStatusController(
              //   getAuthenticatedPlayerModelStreamUseCase:
              //       getAuthenticatedPlayerModelStreamUseCase,
              // );
              final controller = AuthStatusController();

              // given
              streamController.add(null);
              await Future.delayed(Duration.zero);

              // when

              // then
              expect(controller.isError, false);

              // cleanup
            },
          );
        },
      );

      group(".isLoading", () {
        test(
          "given the class"
          "when it is initialized"
          "then should have .isLoading set to true",
          () async {
            // setup
            final streamController =
                StreamController<AuthenticatedPlayerModel?>();
            when(() => getAuthenticatedPlayerModelStreamUseCase())
                .thenAnswer((_) => streamController.stream);
            when(() => loadAuthenticatedPlayerFromRemoteUseCase())
                .thenAnswer((_) async {});

            // given

            // when
            // final controller = AuthStatusController(
            //   getAuthenticatedPlayerModelStreamUseCase:
            //       getAuthenticatedPlayerModelStreamUseCase,
            // );
            final controller = AuthStatusController();

            // then
            expect(controller.isLoading, true);

            // cleanup
          },
        );

        test(
          "given valid data emited from AuthenticatedPlayerModel stream"
          "when data is consumed"
          "then should have .isLoading set to false",
          () async {
            // setup
            final streamController =
                StreamController<AuthenticatedPlayerModel?>();
            when(() => getAuthenticatedPlayerModelStreamUseCase())
                .thenAnswer((_) => streamController.stream);
            when(() => loadAuthenticatedPlayerFromRemoteUseCase()).thenAnswer(
              (_) async {},
            );

            final controller = AuthStatusController();

            // given
            streamController.add(null);
            await Future.delayed(Duration.zero);

            // when

            // then
            expect(controller.isLoading, false);

            // cleanup
          },
        );

        test(
          "given error data emited from AuthenticatedPlayerModel stream"
          "when data is consumed"
          "then should have .isLoading set to false",
          () async {
            // setup
            final streamController =
                StreamController<AuthenticatedPlayerModel?>();
            when(() => getAuthenticatedPlayerModelStreamUseCase())
                .thenAnswer((_) => streamController.stream);
            when(() => loadAuthenticatedPlayerFromRemoteUseCase()).thenAnswer(
              (_) async {},
            );

            final controller = AuthStatusController();

            // given
            streamController.addError(Exception());
            await Future.delayed(Duration.zero);

            // when

            // then
            expect(controller.isLoading, false);

            // cleanup
          },
        );
      });
    },
  );
}

class _MockGetAuthenticatedPlayerModelStreamUseCase extends Mock
    implements GetAuthenticatedPlayerModelStreamUseCase {}

class _MockLoadAuthenticatedPlayerFromRemoteUseCase extends Mock
    implements LoadAuthenticatedPlayerFromRemoteUseCase {}
