import 'dart:math';

import 'package:five_on_4_mobile/src/features/auth/domain/use_cases/sign_out/sign_out_use_case.dart';
import 'package:five_on_4_mobile/src/features/players/domain/models/player/player_model.dart';
import 'package:five_on_4_mobile/src/features/players/domain/use_cases/get_player/get_player_use_case.dart';
import 'package:five_on_4_mobile/src/features/players/domain/use_cases/load_player/load_player_use_case.dart';
import 'package:five_on_4_mobile/src/features/players/presentation/controllers/get_player/provider/get_player_controller.dart';
import 'package:five_on_4_mobile/src/wrappers/libraries/get_it/get_it_wrapper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

void main() {
  final loadPlayerUseCase = _MockLoadPlayerUseCase();
  final getPlayerUseCase = _MockGetPlayerUseCase();
  final signOutUseCase = _MockSignOutUseCase();

  final listener = _MockListener<AsyncValue<GetPlayerControllerState>>();

  setUpAll(() {
    registerFallbackValue(
      AsyncValue.data(_FakeGetPlayerControllerState()),
    );
  });

  setUpAll(() {
    getIt.registerSingleton<LoadPlayerUseCase>(loadPlayerUseCase);
    getIt.registerSingleton<GetPlayerUseCase>(getPlayerUseCase);
    getIt.registerSingleton<SignOutUseCase>(signOutUseCase);
  });

  setUp(() {
    reset(loadPlayerUseCase);
    reset(getPlayerUseCase);
    reset(signOutUseCase);
    reset(listener);
  });

  group(
    "$GetPlayerController",
    () {
      group(
        ".build()",
        () {
          test(
            "given there is an error when [loadPlayerUseCase] is called"
            "when [.build()] is called"
            "then should emit state events in particular order",
            () async {
              // setup
              final ProviderContainer container = ProviderContainer();

              // given
              when(() => loadPlayerUseCase(playerId: any(named: "playerId")))
                  .thenThrow(Exception("error loading player"));

              // when
              // build() is called on instantiate of controller provider
              container.listen(
                getPlayerControllerProvider(playerId: 1),
                listener,
                fireImmediately: true,
              );
              // wait a bit to emit states
              await Future.delayed(Duration.zero);

              // then
              final captured = verifyInOrder([
                () => listener(captureAny(), captureAny()),
                () => listener(captureAny(), captureAny()),
              ]).captured;
              verifyNoMoreInteractions(listener);

              // verify states
              final firstCall = captured[0];
              final secondCall = captured[1];

              final firstCallFirstArg = firstCall[0];
              final firstCallSecondArg = firstCall[1];

              final secondCallFirstArg = secondCall[0];
              final secondCallSecondArg = secondCall[1];

              expect(firstCallFirstArg, isNull);
              expect(firstCallSecondArg,
                  isA<AsyncLoading<GetPlayerControllerState>>());

              expect(secondCallFirstArg,
                  isA<AsyncLoading<GetPlayerControllerState>>());
              expect(secondCallSecondArg,
                  isA<AsyncError<GetPlayerControllerState>>());

              // examine error state
              expect(secondCallSecondArg.error, isA<Exception>());
              expect(secondCallSecondArg.error.toString(),
                  "Exception: error loading player");

              // TODO POSSIBLY TEST FOR STACKTRACE

              // cleanup
              addTearDown(() {
                container.dispose();
              });
            },
          );

          test(
            "given there is an error when [getPlayerUseCase] is called"
            "when [.build()] is called"
            "then should emit state in particular order",
            () async {
              // setup
              final ProviderContainer container = ProviderContainer();

              when(() => loadPlayerUseCase(playerId: any(named: "playerId")))
                  .thenAnswer((_) async {});

              // given
              when(() => getPlayerUseCase(playerId: any(named: "playerId")))
                  .thenThrow(Exception("error getting player"));

              // when
              // build() is called on instantiate of controller provider
              container.listen(
                getPlayerControllerProvider(playerId: 1),
                listener,
                fireImmediately: true,
              );

              // wait a bit to emit states
              await Future.delayed(Duration.zero);

              // then
              final captured = verifyInOrder([
                () => listener(captureAny(), captureAny()),
                () => listener(captureAny(), captureAny()),
              ]).captured;
              verifyNoMoreInteractions(listener);

              // verify states
              final firstCall = captured[0];
              final secondCall = captured[1];

              final firstCallFirstArg = firstCall[0];
              final firstCallSecondArg = firstCall[1];

              final secondCallFirstArg = secondCall[0];
              final secondCallSecondArg = secondCall[1];

              expect(firstCallFirstArg, isNull);
              expect(firstCallSecondArg,
                  isA<AsyncLoading<GetPlayerControllerState>>());

              expect(secondCallFirstArg,
                  isA<AsyncLoading<GetPlayerControllerState>>());
              expect(secondCallSecondArg,
                  isA<AsyncError<GetPlayerControllerState>>());

              // examine error state
              expect(secondCallSecondArg.error, isA<Exception>());
              expect(secondCallSecondArg.error.toString(),
                  "Exception: error getting player");

              // TODO POSSIBLY TEST FOR STACKTRACE

              // cleanup
              addTearDown(() {
                container.dispose();
              });
            },
          );

          test(
            "given successfull call to [LoadPlayerUseCase] and [GetPlayerUseCase]"
            "when [.build()] is called"
            "then should emit state events in particular order",
            () async {
              // setup
              final PlayerModel playerModel = PlayerModel(
                avatarUri: Uri.parse("https://avatar.com"),
                id: 1,
                name: "John Doe",
                nickname: "JD",
              );

              final ProviderContainer container = ProviderContainer();

              // given
              when(() => loadPlayerUseCase(playerId: any(named: "playerId")))
                  .thenAnswer((_) async {});

              when(() => getPlayerUseCase(playerId: any(named: "playerId")))
                  .thenAnswer((_) async => playerModel);

              // when
              // build() is called on instantiate of controller provider
              container.listen(
                getPlayerControllerProvider(playerId: 1),
                listener,
                fireImmediately: true,
              );
              await Future.delayed(Duration.zero);

              // then
              final captured = verifyInOrder([
                () => listener(captureAny(), captureAny()),
                () => listener(captureAny(), captureAny()),
              ]).captured;
              verifyNoMoreInteractions(listener);

              // verify states
              final firstCall = captured[0];
              final secondCall = captured[1];

              final firstCallFirstArg = firstCall[0];
              final firstCallSecondArg = firstCall[1];

              final secondCallFirstArg = secondCall[0];
              final secondCallSecondArg = secondCall[1];

              expect(firstCallFirstArg, isNull);
              expect(firstCallSecondArg,
                  isA<AsyncLoading<GetPlayerControllerState>>());

              expect(secondCallFirstArg,
                  isA<AsyncLoading<GetPlayerControllerState>>());
              expect(secondCallSecondArg,
                  isA<AsyncData<GetPlayerControllerState>>());

              // examine data state
              expect(
                  secondCallSecondArg.value, isA<GetPlayerControllerState>());
              expect(secondCallSecondArg.value.player, playerModel);

              // cleanup
              addTearDown(() {
                container.dispose();
              });
            },
          );
        },
      );
    },
  );
}

class _MockLoadPlayerUseCase extends Mock implements LoadPlayerUseCase {}

class _MockGetPlayerUseCase extends Mock implements GetPlayerUseCase {}

class _MockSignOutUseCase extends Mock implements SignOutUseCase {}

class _MockListener<T> extends Mock {
  void call(T? previous, T next);
}

class _FakeGetPlayerControllerState extends Fake
    implements GetPlayerControllerState {}
