// test that intiial state is false

// test that when call handleAuthenticate() then state is emitted in specific order

// test when error should emit in specific order

import 'package:five_on_4_mobile/src/features/auth/domain/use_cases/authenticate_with_google/authenticate_with_google_use_case.dart';
import 'package:five_on_4_mobile/src/features/auth/presentation/controllers/authenticate_with_google/authenticate_with_google_controller.dart';
import 'package:five_on_4_mobile/src/wrappers/libraries/get_it/get_it_wrapper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  final authenticateWithGoogleUseCase = _MockAuthenticateWithGoogleUseCase();

  // controller state listener
  final listener = _MockListener<AsyncValue<bool>>();

  setUpAll(() {
    registerFallbackValue(const AsyncValue.data(false));
    registerFallbackValue(StackTrace.empty);
  });

  setUpAll(() {
    getIt.registerSingleton<AuthenticateWithGoogleUseCase>(
        authenticateWithGoogleUseCase);
  });

  tearDown(() {
    reset(authenticateWithGoogleUseCase);
    reset(listener);
  });

  group(
    "$AuthenticateWithGoogleUseCase",
    () {
      group(
        ".initial state",
        () {
          test(
            "given the AuthenticateWithGoogleController"
            "when the class is initialized"
            "then should emit state with false",
            () async {
              // setup
              final providerContainer = ProviderContainer();
              addTearDown(() {
                providerContainer.dispose();
              });

              providerContainer.listen(
                authenticateWithGoogleControllerProvider,
                listener,
                fireImmediately: true,
              );
              // given

              // when

              // then
              verify(() => listener(null, const AsyncValue.data(false)));
              verifyNoMoreInteractions(listener);

              // cleanup
            },
          );
        },
      );

      group(".onAuthenticate()", () {
        // when on authenticate throws error should emit states in specific order
        test(
          "given an error during authentication"
          "when .onAuthenticate() is called"
          "then should emit specific events in specific order",
          () async {
            // setup

            final expectedException = Exception("error");

            final providerContainer = ProviderContainer();
            addTearDown(() {
              providerContainer.dispose();
            });

            providerContainer.listen(
              authenticateWithGoogleControllerProvider,
              listener,
              fireImmediately: true,
            );
            // this is initial state
            verify(() => listener(null, const AsyncValue.data(false)));

            // given
            when(() => authenticateWithGoogleUseCase()).thenThrow(
              expectedException,
            );

            // when
            await providerContainer
                .read(authenticateWithGoogleControllerProvider.notifier)
                .onAuthenticate();

            // then
            verifyInOrder(
              [
                () => listener(
                      const AsyncValue<bool>.data(false),
                      const AsyncValue<bool>.loading(),
                    ),
                () => listener(
                      const AsyncValue<bool>.loading(),
                      // any(that: isA<AsyncValue<bool>>()),
                      // any(),
                      AsyncValue<bool>.error(
                        expectedException,
                        // TODO create custom matcher for this so that we dont have to pass stack trace empty here
                        StackTrace.empty,
                      ),
                    ),
              ],
            );
            verifyNoMoreInteractions(listener);

            // cleanup
          },
        );

        // when on authenticate is successful should emit states in specific order
        test(
          "given a successful authentication"
          "when .onAuthenticate() is called"
          "then should emit specific events in specific order",
          () async {
            // setup

            final providerContainer = ProviderContainer();
            addTearDown(() {
              providerContainer.dispose();
            });

            providerContainer.listen(
              authenticateWithGoogleControllerProvider,
              listener,
              fireImmediately: true,
            );
            // this is initial state
            verify(() => listener(null, const AsyncValue.data(false)));

            // given
            when(() => authenticateWithGoogleUseCase()).thenAnswer(
              (_) async {},
            );

            // when
            await providerContainer
                .read(authenticateWithGoogleControllerProvider.notifier)
                .onAuthenticate();

            // then
            verifyInOrder(
              [
                () => listener(
                      const AsyncValue<bool>.data(false),
                      const AsyncValue<bool>.loading(),
                    ),
                () => listener(
                      const AsyncValue<bool>.loading(),
                      const AsyncValue<bool>.data(true),
                    ),
              ],
            );
            verifyNoMoreInteractions(listener);

            // cleanup
          },
        );
      });
    },
  );
}

class _MockAuthenticateWithGoogleUseCase extends Mock
    implements AuthenticateWithGoogleUseCase {}

class _MockListener<T> extends Mock {
  void call(T? previous, T next);
}
