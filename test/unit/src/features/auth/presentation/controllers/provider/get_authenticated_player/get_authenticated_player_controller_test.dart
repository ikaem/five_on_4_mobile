import 'package:five_on_4_mobile/src/features/auth/domain/exceptions/auth_exceptions.dart';
import 'package:five_on_4_mobile/src/features/auth/domain/models/authenticated_player/authenticated_player_model.dart';
import 'package:five_on_4_mobile/src/features/auth/domain/use_cases/get_authenticated_player_model/get_authenticated_player_model_use_case.dart';
import 'package:five_on_4_mobile/src/features/auth/domain/use_cases/sign_out/sign_out_use_case.dart';
import 'package:five_on_4_mobile/src/features/auth/presentation/controllers/get_authenticated_player/provider/get_authenticated_player_controller.dart';
import 'package:five_on_4_mobile/src/features/auth/presentation/controllers/get_authenticated_player/provider/get_authenticated_player_controller_state.dart';
import 'package:five_on_4_mobile/src/wrappers/libraries/get_it/get_it_wrapper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

void main() {
  final getAuthenticatedPlayerModelUseCase =
      _MockGetAuthenticatedPlayerModelUseCase();
  final signOutUseCase = _MockSignOutUseCase();

  final listener =
      _MockListener<AsyncValue<GetAuthenticatedPlayerControllerState>>();

  setUpAll(
    () {
      registerFallbackValue(
        AsyncValue.data(_FakeGetAuthenticatedPlayerControllerState()),
      );
    },
  );

  setUpAll(
    () {
      getIt.registerSingleton<GetAuthenticatedPlayerModelUseCase>(
        getAuthenticatedPlayerModelUseCase,
      );
      getIt.registerSingleton<SignOutUseCase>(signOutUseCase);
    },
  );

  tearDown(() {
    reset(getAuthenticatedPlayerModelUseCase);
    reset(signOutUseCase);
    reset(listener);
  });

  group("$GetAuthenticatedPlayerController", () {
    group(".build()", () {
      // given no logged in player error
      test(
        "given there is an [AuthNotLoggedInException] error when [GetAuthenticatedPlayerModelUseCase] is called"
        "when [.build()] is called"
        "then should emit state events in particular order and call [SignOutUseCase]",
        () async {
          // setup
          final container = ProviderContainer();

          // given
          when(() => getAuthenticatedPlayerModelUseCase())
              .thenThrow(const AuthNotLoggedInException());
          when(() => signOutUseCase()).thenAnswer((_) async {});

          // when
          // build() is called on instantiate of controller provider
          container.listen(
            getAuthenticatedPlayerControllerProvider,
            listener,
            fireImmediately: true,
          );
          // wait a bit to emit states
          await Future.delayed(Duration.zero);

          // then
          // verifyInOrder([
          //   () => listener(
          //         null,
          //         const AsyncError<GetAuthenticatedPlayerControllerState>(),
          //       ),
          // ]);

          // capturing because rehtrow in controller causes StackTrace to be unpredictable
          final captured = verifyInOrder([
            () => listener(captureAny(), captureAny()),
            () => listener(captureAny(), captureAny()),
          ]).captured;
          verifyNoMoreInteractions(listener);

          // print("hello");
          // verify calls
          verify(() => signOutUseCase()).called(1);

          // verify states
          final firstCall = captured[0];
          final secondCall = captured[1];

          final firstCallFirstArg = firstCall[0];
          final firstCallSecondArg = firstCall[1];

          final secondCallFirstArg = secondCall[0];
          final secondCallSecondArg = secondCall[1];

          expect(firstCallFirstArg, isNull);
          expect(firstCallSecondArg,
              isA<AsyncLoading<GetAuthenticatedPlayerControllerState>>());

          expect(secondCallFirstArg,
              isA<AsyncLoading<GetAuthenticatedPlayerControllerState>>());
          expect(secondCallSecondArg,
              isA<AsyncError<GetAuthenticatedPlayerControllerState>>());

          // examine error state
          expect(secondCallSecondArg.error, isA<AuthNotLoggedInException>());
          expect(
            secondCallSecondArg.error.toString(),
            equals("AuthException -> User is not logged in"),
          );

          // cleanup
          addTearDown(() {
            container.dispose();
          });
        },
      );

      // given some other error
      test(
        "given there is an [Exception] when [GetAuthenticatedPlayerModelUseCase] is called"
        "when [.build()] is called"
        "then should emit state events in particular order and",
        () async {
          // setup
          final container = ProviderContainer();

          // given
          when(() => getAuthenticatedPlayerModelUseCase())
              .thenThrow(Exception("Error getting player"));
          // when(() => signOutUseCase()).thenAnswer((_) async {});

          // when
          // build() is called on instantiate of controller provider
          container.listen(
            getAuthenticatedPlayerControllerProvider,
            listener,
            fireImmediately: true,
          );
          // wait a bit to emit states
          await Future.delayed(Duration.zero);

          // then
          // verifyInOrder([
          //   () => listener(
          //         null,
          //         const AsyncError<GetAuthenticatedPlayerControllerState>(),
          //       ),
          // ]);

          // capturing because rehtrow in controller causes StackTrace to be unpredictable
          final captured = verifyInOrder([
            () => listener(captureAny(), captureAny()),
            () => listener(captureAny(), captureAny()),
          ]).captured;
          verifyNoMoreInteractions(listener);

          // print("hello");
          verifyNever(() => signOutUseCase());

          // verify states
          final firstCall = captured[0];
          final secondCall = captured[1];

          final firstCallFirstArg = firstCall[0];
          final firstCallSecondArg = firstCall[1];

          final secondCallFirstArg = secondCall[0];
          final secondCallSecondArg = secondCall[1];

          expect(firstCallFirstArg, isNull);
          expect(firstCallSecondArg,
              isA<AsyncLoading<GetAuthenticatedPlayerControllerState>>());

          expect(secondCallFirstArg,
              isA<AsyncLoading<GetAuthenticatedPlayerControllerState>>());
          expect(secondCallSecondArg,
              isA<AsyncError<GetAuthenticatedPlayerControllerState>>());

          // examine error state
          expect(secondCallSecondArg.error, isA<Exception>());
          expect(
            secondCallSecondArg.error.toString(),
            equals("Exception: Error getting player"),
          );

          // cleanup
          addTearDown(() {
            container.dispose();
          });
        },
      );

      // ćgiven success
      test(
        "given there is an [AuthenticatedPlayerModel] returned when [GetAuthenticatedPlayerModelUseCase] is called"
        "when [.build()] is called"
        "then should emit state events in particular order",
        () async {
          // setup
          final container = ProviderContainer();

          // given
          const authenticatedPlayerModel = AuthenticatedPlayerModel(
            playerId: 1,
            playerName: "playerName",
            playerNickname: "playerNickname",
          );
          when(() => getAuthenticatedPlayerModelUseCase())
              .thenAnswer((_) async => authenticatedPlayerModel);
          // when(() => signOutUseCase()).thenAnswer((_) async {});

          // when
          // build() is called on instantiate of controller provider
          container.listen(
            getAuthenticatedPlayerControllerProvider,
            listener,
            fireImmediately: true,
          );
          // wait a bit to emit states
          await Future.delayed(Duration.zero);

          // then
          // verifyInOrder([
          //   () => listener(
          //         null,
          //         const AsyncError<GetAuthenticatedPlayerControllerState>(),
          //       ),
          // ]);

          // capturing because rehtrow in controller causes StackTrace to be unpredictable
          final captured = verifyInOrder([
            () => listener(captureAny(), captureAny()),
            () => listener(captureAny(), captureAny()),
          ]).captured;
          verifyNoMoreInteractions(listener);

          // print("hello");
          verifyNever(() => signOutUseCase());

          // verify states
          final firstCall = captured[0];
          final secondCall = captured[1];

          final firstCallFirstArg = firstCall[0];
          final firstCallSecondArg = firstCall[1];

          final secondCallFirstArg = secondCall[0];
          final secondCallSecondArg = secondCall[1];

          expect(firstCallFirstArg, isNull);
          expect(firstCallSecondArg,
              isA<AsyncLoading<GetAuthenticatedPlayerControllerState>>());

          expect(secondCallFirstArg,
              isA<AsyncLoading<GetAuthenticatedPlayerControllerState>>());
          // expect(secondCallSecondArg,
          //     isA<AsyncError<GetAuthenticatedPlayerControllerState>>());
          expect(
            secondCallSecondArg,
            isA<AsyncData<GetAuthenticatedPlayerControllerState>>(),
          );

          // examine error state
          expect(secondCallSecondArg.value,
              isA<GetAuthenticatedPlayerControllerState>());
          expect(secondCallSecondArg.value.authenticatedPlayer,
              equals(authenticatedPlayerModel)
              // equals("Exception: Error getting player"),
              );

          // cleanup
          addTearDown(() {
            container.dispose();
          });
        },
      );
    });
  });
}

class _MockGetAuthenticatedPlayerModelUseCase extends Mock
    implements GetAuthenticatedPlayerModelUseCase {}

class _MockSignOutUseCase extends Mock implements SignOutUseCase {}

class _MockListener<T> extends Mock {
  // NOTE seems no need to stub this
  void call(T? prev, T next);
}

class _FakeGetAuthenticatedPlayerControllerState extends Fake
    implements GetAuthenticatedPlayerControllerState {}
