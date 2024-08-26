import 'package:five_on_4_mobile/src/features/auth/domain/models/authenticated_player/authenticated_player_model.dart';
import 'package:five_on_4_mobile/src/features/auth/domain/use_cases/get_authenticated_player_model/get_authenticated_player_model_use_case.dart';
import 'package:five_on_4_mobile/src/features/auth/domain/use_cases/sign_out/sign_out_use_case.dart';
import 'package:five_on_4_mobile/src/features/player_match_participation/domain/use_cases/join_match/join_match_use_case.dart';
import 'package:five_on_4_mobile/src/features/player_match_participation/domain/use_cases/unjoin_match/unjoin_match_use_case.dart';
import 'package:five_on_4_mobile/src/features/player_match_participation/presentation/controllers/join_match/provider/join_match_controller.dart';
import 'package:five_on_4_mobile/src/features/player_match_participation/presentation/controllers/unjoin_match/provider/unjoin_match_controller.dart';
import 'package:five_on_4_mobile/src/wrappers/libraries/get_it/get_it_wrapper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

void main() {
  final unjoinMatchUseCase = _MockUnjoinMatchUseCase();
  final getAuthenticatedPlayerModelUseCase =
      _MockGetAuthenticatedPlayerModelUseCase();
  final signOutUseCase = _MockSignOutUseCase();

  final listener = _MockListener<AsyncValue<UnjoinMatchControllerState?>>();

  setUpAll(() {
    registerFallbackValue(AsyncValue.data(_FakeJoinMatchControllerState()));
  });

  setUpAll(() {
    getIt.registerSingleton<UnjoinMatchUseCase>(unjoinMatchUseCase);
    getIt.registerSingleton<GetAuthenticatedPlayerModelUseCase>(
        getAuthenticatedPlayerModelUseCase);
    getIt.registerSingleton<SignOutUseCase>(signOutUseCase);
  });

  tearDownAll(() {
    // TODO this also works
    // getIt.reset();

    reset(unjoinMatchUseCase);
    reset(getAuthenticatedPlayerModelUseCase);
    reset(signOutUseCase);

    reset(listener);
  });

  group("$UnjoinMatchController", () {
    group(
      ".build()",
      () {
        test(
          "given [UnjoinMatchController] "
          "when [.build()] "
          "then should emit expected state",
          () async {
            // setup
            final providerContainer = ProviderContainer();

            // given

            // when
            providerContainer.listen(
              unjoinMatchControllerProvider,
              listener,
              fireImmediately: true,
            );

            // then
            verifyInOrder([
              () => listener(null,
                  const AsyncValue<UnjoinMatchControllerState?>.data(null)),
            ]);
            verifyNoMoreInteractions(listener);

            // cleanup
            addTearDown(() {
              providerContainer.dispose();
            });
          },
        );
      },
    );

    group(
      ".onJoinMatch()",
      () {
        const AuthenticatedPlayerModel authPlayerModel =
            AuthenticatedPlayerModel(
          playerId: 1,
          playerName: "name",
          playerNickname: "nickname",
        );

        test(
          "given there is no [AuthenticatedPlayerModel] "
          "when [.onUnjoinMatch()] is called "
          "then should make expecteced calls to use cases and emit events in specific order.",
          () async {
            // setup
            when(() => signOutUseCase()).thenAnswer((_) async {});

            final providerContainer = ProviderContainer();

            // given
            when(() => getAuthenticatedPlayerModelUseCase())
                .thenAnswer((_) async => null);

            // when
            providerContainer.listen(
              unjoinMatchControllerProvider,
              listener,
              fireImmediately: true,
            );

            await providerContainer
                .read(unjoinMatchControllerProvider.notifier)
                .onUnjoinMatch(
                  matchId: 1,
                );

            // then
            verifyInOrder([
              () => listener(
                    null,
                    const AsyncValue<UnjoinMatchControllerState?>.data(null),
                  ),
              () => listener(
                    const AsyncValue<UnjoinMatchControllerState?>.data(null),
                    const AsyncValue<UnjoinMatchControllerState?>.loading(),
                  ),
              () => listener(
                    const AsyncValue<UnjoinMatchControllerState?>.loading(),
                    const AsyncValue<UnjoinMatchControllerState?>.error(
                      "User is not logged in",
                      StackTrace.empty,
                    ),
                  ),
            ]);
            verifyNoMoreInteractions(listener);

            // verify calls to use cases
            verify(() => getAuthenticatedPlayerModelUseCase()).called(1);
            verify(() => signOutUseCase()).called(1);

            verifyNever(() => unjoinMatchUseCase(
                matchId: any(named: "matchId"),
                playerId: any(named: "playerId")));

            // cleanup
            addTearDown(() {
              providerContainer.dispose();
            });
          },
        );

        test(
          "given there is an error during joining match "
          "when [.onJoinMatch()] is called "
          "then should make expecteced calls to use cases and emit events in specific order.",
          () async {
            // setup
            // when(() => signOutUseCase()).thenAnswer((_) async {});
            when(() => getAuthenticatedPlayerModelUseCase())
                .thenAnswer((_) async => authPlayerModel);

            final providerContainer = ProviderContainer();

            // given
            when(() => unjoinMatchUseCase(
                  matchId: any(named: "matchId"),
                  playerId: any(named: "playerId"),
                )).thenThrow(Exception("error"));

            // when
            providerContainer.listen(
              unjoinMatchControllerProvider,
              listener,
              fireImmediately: true,
            );

            await providerContainer
                .read(unjoinMatchControllerProvider.notifier)
                .onUnjoinMatch(
                  matchId: 1,
                );

            // then
            verifyInOrder([
              () => listener(
                    null,
                    const AsyncValue<UnjoinMatchControllerState?>.data(null),
                  ),
              () => listener(
                    const AsyncValue<UnjoinMatchControllerState?>.data(null),
                    const AsyncValue<UnjoinMatchControllerState?>.loading(),
                  ),
              () => listener(
                    const AsyncValue<UnjoinMatchControllerState?>.loading(),
                    const AsyncValue<UnjoinMatchControllerState?>.error(
                      "Error unjoining a match",
                      StackTrace.empty,
                    ),
                  ),
            ]);
            verifyNoMoreInteractions(listener);

            // verify calls to use cases
            verify(() => getAuthenticatedPlayerModelUseCase()).called(1);
            verify(() => unjoinMatchUseCase(
                  matchId: 1,
                  playerId: 1,
                )).called(1);

            verifyNever(() => signOutUseCase());

            // cleanup
            addTearDown(() {
              providerContainer.dispose();
            });
          },
        );

        test(
          "given there is no error during unjoining match "
          "when [.onUnjoinMatch()] is called "
          "then should make expecteced calls to use cases and emit events in specific order.",
          () async {
            // setup
            // when(() => signOutUseCase()).thenAnswer((_) async {});
            when(() => getAuthenticatedPlayerModelUseCase())
                .thenAnswer((_) async => authPlayerModel);

            final providerContainer = ProviderContainer();

            // given
            when(() => unjoinMatchUseCase(
                  matchId: any(named: "matchId"),
                  playerId: any(named: "playerId"),
                )).thenAnswer((_) async => 1);

            // when
            providerContainer.listen(
              unjoinMatchControllerProvider,
              listener,
              fireImmediately: true,
            );

            await providerContainer
                .read(unjoinMatchControllerProvider.notifier)
                .onUnjoinMatch(
                  matchId: 1,
                );

            // then
            verifyInOrder([
              () => listener(
                    null,
                    const AsyncValue<UnjoinMatchControllerState?>.data(null),
                  ),
              () => listener(
                    const AsyncValue<UnjoinMatchControllerState?>.data(null),
                    const AsyncValue<UnjoinMatchControllerState?>.loading(),
                  ),
              () => listener(
                    const AsyncValue<UnjoinMatchControllerState?>.loading(),
                    const AsyncValue<UnjoinMatchControllerState?>.data(
                      UnjoinMatchControllerState(participationId: 1),
                    ),
                  ),
            ]);
            verifyNoMoreInteractions(listener);

            // verify calls to use cases
            verify(() => getAuthenticatedPlayerModelUseCase()).called(1);
            verify(() => unjoinMatchUseCase(
                  matchId: 1,
                  playerId: 1,
                )).called(1);

            verifyNever(() => signOutUseCase());

            // cleanup
            addTearDown(() {
              providerContainer.dispose();
            });
          },
        );
      },
    );
  });
}

class _MockGetAuthenticatedPlayerModelUseCase extends Mock
    implements GetAuthenticatedPlayerModelUseCase {}

class _MockUnjoinMatchUseCase extends Mock implements UnjoinMatchUseCase {}

class _MockSignOutUseCase extends Mock implements SignOutUseCase {}

class _MockListener<T> extends Mock {
  void call(T? previous, T next);
}

class _FakeJoinMatchControllerState extends Fake
    implements JoinMatchControllerState {}
