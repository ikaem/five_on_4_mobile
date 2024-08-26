import 'package:five_on_4_mobile/src/features/auth/domain/models/authenticated_player/authenticated_player_model.dart';
import 'package:five_on_4_mobile/src/features/auth/domain/use_cases/get_authenticated_player_model/get_authenticated_player_model_use_case.dart';
import 'package:five_on_4_mobile/src/features/auth/domain/use_cases/sign_out/sign_out_use_case.dart';
import 'package:five_on_4_mobile/src/features/player_match_participation/domain/use_cases/join_match/join_match_use_case.dart';
import 'package:five_on_4_mobile/src/features/player_match_participation/presentation/controllers/join_match/provider/join_match_controller.dart';
import 'package:five_on_4_mobile/src/wrappers/libraries/get_it/get_it_wrapper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

void main() {
  final joinMatchUseCase = _MockJoinMatchUseCase();
  final getAuthenticatedPlayerModelUseCase =
      _MockGetAuthenticatedPlayerModelUseCase();
  final signOutUseCase = _MockSignOutUseCase();

  final listener = _MockListener<AsyncValue<JoinMatchControllerState?>>();

  setUpAll(() {
    registerFallbackValue(AsyncValue.data(_FakeJoinMatchControllerState()));
  });

  setUpAll(() {
    getIt.registerSingleton<JoinMatchUseCase>(joinMatchUseCase);
    getIt.registerSingleton<GetAuthenticatedPlayerModelUseCase>(
        getAuthenticatedPlayerModelUseCase);
    getIt.registerSingleton<SignOutUseCase>(signOutUseCase);
  });

  tearDownAll(() {
    // TODO this also works
    // getIt.reset();

    reset(joinMatchUseCase);
    reset(getAuthenticatedPlayerModelUseCase);
    reset(signOutUseCase);

    reset(listener);
  });

  group("$JoinMatchController", () {
    group(
      ".build()",
      () {
        test(
          "given [JoinMatchController] "
          "when [.build()] "
          "then should emit expected state",
          () async {
            // setup
            final providerContainer = ProviderContainer();

            // given

            // when
            providerContainer.listen(
              joinMatchControllerProvider,
              listener,
              fireImmediately: true,
            );

            // then
            verifyInOrder([
              () => listener(
                  null, const AsyncValue<JoinMatchControllerState?>.data(null)),
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
          "when [.onJoinMatch()] is called "
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
              joinMatchControllerProvider,
              listener,
              fireImmediately: true,
            );

            await providerContainer
                .read(joinMatchControllerProvider.notifier)
                .onJoinMatch(
                  matchId: 1,
                );

            // then
            verifyInOrder([
              () => listener(
                    null,
                    const AsyncValue<JoinMatchControllerState?>.data(null),
                  ),
              () => listener(
                    const AsyncValue<JoinMatchControllerState?>.data(null),
                    const AsyncValue<JoinMatchControllerState?>.loading(),
                  ),
              () => listener(
                    const AsyncValue<JoinMatchControllerState?>.loading(),
                    const AsyncValue<JoinMatchControllerState?>.error(
                      "User is not logged in",
                      StackTrace.empty,
                    ),
                  ),
            ]);
            verifyNoMoreInteractions(listener);

            // verify calls to use cases
            verify(() => getAuthenticatedPlayerModelUseCase()).called(1);
            verify(() => signOutUseCase()).called(1);

            verifyNever(() => joinMatchUseCase(
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
            when(() => joinMatchUseCase(
                  matchId: any(named: "matchId"),
                  playerId: any(named: "playerId"),
                )).thenThrow(Exception("error"));

            // when
            providerContainer.listen(
              joinMatchControllerProvider,
              listener,
              fireImmediately: true,
            );

            await providerContainer
                .read(joinMatchControllerProvider.notifier)
                .onJoinMatch(
                  matchId: 1,
                );

            // then
            verifyInOrder([
              () => listener(
                    null,
                    const AsyncValue<JoinMatchControllerState?>.data(null),
                  ),
              () => listener(
                    const AsyncValue<JoinMatchControllerState?>.data(null),
                    const AsyncValue<JoinMatchControllerState?>.loading(),
                  ),
              () => listener(
                    const AsyncValue<JoinMatchControllerState?>.loading(),
                    const AsyncValue<JoinMatchControllerState?>.error(
                      "Error joining a match",
                      StackTrace.empty,
                    ),
                  ),
            ]);
            verifyNoMoreInteractions(listener);

            // verify calls to use cases
            verify(() => getAuthenticatedPlayerModelUseCase()).called(1);
            verify(() => joinMatchUseCase(
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
          "given there is no error during joining match "
          "when [.onJoinMatch()] is called "
          "then should make expecteced calls to use cases and emit events in specific order.",
          () async {
            // setup
            // when(() => signOutUseCase()).thenAnswer((_) async {});
            when(() => getAuthenticatedPlayerModelUseCase())
                .thenAnswer((_) async => authPlayerModel);

            final providerContainer = ProviderContainer();

            // given
            when(() => joinMatchUseCase(
                  matchId: any(named: "matchId"),
                  playerId: any(named: "playerId"),
                )).thenAnswer((_) async => 1);

            // when
            providerContainer.listen(
              joinMatchControllerProvider,
              listener,
              fireImmediately: true,
            );

            await providerContainer
                .read(joinMatchControllerProvider.notifier)
                .onJoinMatch(
                  matchId: 1,
                );

            // then
            verifyInOrder([
              () => listener(
                    null,
                    const AsyncValue<JoinMatchControllerState?>.data(null),
                  ),
              () => listener(
                    const AsyncValue<JoinMatchControllerState?>.data(null),
                    const AsyncValue<JoinMatchControllerState?>.loading(),
                  ),
              () => listener(
                    const AsyncValue<JoinMatchControllerState?>.loading(),
                    const AsyncValue<JoinMatchControllerState?>.data(
                      JoinMatchControllerState(participationId: 1),
                    ),
                  ),
            ]);
            verifyNoMoreInteractions(listener);

            // verify calls to use cases
            verify(() => getAuthenticatedPlayerModelUseCase()).called(1);
            verify(() => joinMatchUseCase(
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

class _MockJoinMatchUseCase extends Mock implements JoinMatchUseCase {}

class _MockSignOutUseCase extends Mock implements SignOutUseCase {}

class _MockListener<T> extends Mock {
  void call(T? previous, T next);
}

class _FakeJoinMatchControllerState extends Fake
    implements JoinMatchControllerState {}
