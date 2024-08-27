import 'package:five_on_4_mobile/src/features/auth/domain/models/authenticated_player/authenticated_player_model.dart';
import 'package:five_on_4_mobile/src/features/auth/domain/use_cases/get_authenticated_player_model/get_authenticated_player_model_use_case.dart';
import 'package:five_on_4_mobile/src/features/auth/domain/use_cases/sign_out/sign_out_use_case.dart';
import 'package:five_on_4_mobile/src/features/player_match_participation/domain/use_cases/invite_to_match/invite_to_match_use_case.dart';
import 'package:five_on_4_mobile/src/features/player_match_participation/domain/use_cases/join_match/join_match_use_case.dart';
import 'package:five_on_4_mobile/src/features/player_match_participation/domain/use_cases/unjoin_match/unjoin_match_use_case.dart';
import 'package:five_on_4_mobile/src/features/player_match_participation/presentation/controllers/invite_to_match/provider/invite_to_match_controller.dart';
import 'package:five_on_4_mobile/src/features/player_match_participation/presentation/controllers/join_match/provider/join_match_controller.dart';
import 'package:five_on_4_mobile/src/features/player_match_participation/presentation/controllers/unjoin_match/provider/unjoin_match_controller.dart';
import 'package:five_on_4_mobile/src/wrappers/libraries/get_it/get_it_wrapper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

void main() {
  final inviteToMatchUseCase = _MockInviteToMatchUseCase();
  // final getAuthenticatedPlayerModelUseCase =
  //     _MockGetAuthenticatedPlayerModelUseCase();
  final signOutUseCase = _MockSignOutUseCase();

  final listener = _MockListener<AsyncValue<InviteToMatchControllerState?>>();

  setUpAll(() {
    registerFallbackValue(AsyncValue.data(_FakeInviteToMatchControllerState()));
  });

  setUpAll(() {
    getIt.registerSingleton<InviteToMatchUseCase>(inviteToMatchUseCase);
    // getIt.registerSingleton<GetAuthenticatedPlayerModelUseCase>(
    //     getAuthenticatedPlayerModelUseCase);
    getIt.registerSingleton<SignOutUseCase>(signOutUseCase);
  });

  tearDownAll(() {
    // TODO this also works
    // getIt.reset();

    reset(inviteToMatchUseCase);
    // reset(getAuthenticatedPlayerModelUseCase);
    reset(signOutUseCase);

    reset(listener);
  });

  group("$InviteToMatchController", () {
    group(
      ".build()",
      () {
        test(
          "given [InviteToMatchController] "
          "when [.build()] "
          "then should emit expected state",
          () async {
            // setup
            final providerContainer = ProviderContainer();

            // given

            // when
            providerContainer.listen(
              inviteToMatchControllerProvider,
              listener,
              fireImmediately: true,
            );

            // then
            verifyInOrder([
              () => listener(null,
                  const AsyncValue<InviteToMatchControllerState?>.data(null)),
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
      ".onInviteToMatch()",
      () {
        const AuthenticatedPlayerModel authPlayerModel =
            AuthenticatedPlayerModel(
          playerId: 1,
          playerName: "name",
          playerNickname: "nickname",
        );

        // TODO will need to test what if auth error on invite to match - not suzre if logic is implemented either

        test(
          "given there is an error during inviting to a match "
          "when [.onInviteToMatch()] is called "
          "then should make expecteced calls to use cases and emit events in specific order.",
          () async {
            // setup
            // when(() => signOutUseCase()).thenAnswer((_) async {});
            // when(() => getAuthenticatedPlayerModelUseCase())
            //     .thenAnswer((_) async => authPlayerModel);

            final providerContainer = ProviderContainer();

            // given
            when(() => inviteToMatchUseCase(
                  matchId: any(named: "matchId"),
                  playerId: any(named: "playerId"),
                )).thenThrow(Exception("error"));

            // when
            providerContainer.listen(
              inviteToMatchControllerProvider,
              listener,
              fireImmediately: true,
            );

            await providerContainer
                .read(inviteToMatchControllerProvider.notifier)
                .onInviteToMatch(
                  matchId: 1,
                  playerId: 1,
                );

            // then
            verifyInOrder([
              () => listener(
                    null,
                    const AsyncValue<InviteToMatchControllerState?>.data(null),
                  ),
              () => listener(
                    const AsyncValue<InviteToMatchControllerState?>.data(null),
                    const AsyncValue<InviteToMatchControllerState?>.loading(),
                  ),
              () => listener(
                    const AsyncValue<InviteToMatchControllerState?>.loading(),
                    const AsyncValue<InviteToMatchControllerState?>.error(
                      "Error inviting player to a match",
                      StackTrace.empty,
                    ),
                  ),
            ]);
            verifyNoMoreInteractions(listener);

            // verify calls to use cases
            // verify(() => getAuthenticatedPlayerModelUseCase()).called(1);
            verify(() => inviteToMatchUseCase(
                  matchId: 1,
                  playerId: 1,
                )).called(1);

            // verifyNever(() => signOutUseCase());

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
            // when(() => getAuthenticatedPlayerModelUseCase())
            // .thenAnswer((_) async => authPlayerModel);

            final providerContainer = ProviderContainer();

            // given
            when(() => inviteToMatchUseCase(
                  matchId: any(named: "matchId"),
                  playerId: any(named: "playerId"),
                )).thenAnswer((_) async => 1);

            // when
            providerContainer.listen(
              inviteToMatchControllerProvider,
              listener,
              fireImmediately: true,
            );

            await providerContainer
                .read(inviteToMatchControllerProvider.notifier)
                .onInviteToMatch(
                  matchId: 1,
                  playerId: 1,
                );

            // then
            verifyInOrder([
              () => listener(
                    null,
                    const AsyncValue<InviteToMatchControllerState?>.data(null),
                  ),
              () => listener(
                    const AsyncValue<InviteToMatchControllerState?>.data(null),
                    const AsyncValue<InviteToMatchControllerState?>.loading(),
                  ),
              () => listener(
                    const AsyncValue<InviteToMatchControllerState?>.loading(),
                    const AsyncValue<InviteToMatchControllerState?>.data(
                      InviteToMatchControllerState(participationId: 1),
                    ),
                  ),
            ]);
            verifyNoMoreInteractions(listener);

            // verify calls to use cases
            // verify(() => getAuthenticatedPlayerModelUseCase()).called(1);
            verify(() => inviteToMatchUseCase(
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

// class _MockGetAuthenticatedPlayerModelUseCase extends Mock
//     implements GetAuthenticatedPlayerModelUseCase {}

class _MockInviteToMatchUseCase extends Mock implements InviteToMatchUseCase {}

class _MockSignOutUseCase extends Mock implements SignOutUseCase {}

class _MockListener<T> extends Mock {
  void call(T? previous, T next);
}

class _FakeInviteToMatchControllerState extends Fake
    implements InviteToMatchControllerState {}
