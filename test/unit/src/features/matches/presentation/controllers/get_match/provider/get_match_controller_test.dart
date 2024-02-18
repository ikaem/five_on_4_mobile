import 'package:five_on_4_mobile/src/features/matches/domain/use_cases/get_match/get_match_use_case.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/use_cases/get_match/provider/get_match_use_case_provider.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/use_cases/load_match/load_match_use_case.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/use_cases/load_match/provider/load_match_use_case_provider.dart';
import 'package:five_on_4_mobile/src/features/matches/presentation/controllers/get_match/provider/get_match_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../../../../utils/data/test_models.dart';

void main() {
  group(
    "$GetMatchController",
    () {
      group(
        "NON-error state",
        () {
          test(
            "given a controller instance and connected to internet"
            "when instance is created "
            "then emits state in specific order",
            () async {
              final match = getTestMatchModel();

              final getMatchUseCase = _MockGetMatchUseCase();
              final loadMatchUseCase = _MockLoadMatchUseCase();

              when(
                () => loadMatchUseCase(
                  matchId: match.id,
                ),
              ).thenAnswer(
                (_) async => match.id,
              );
              when(
                () => getMatchUseCase(
                  matchId: match.id,
                ),
              ).thenAnswer(
                (_) async => match,
              );

              final providerContaiuner = ProviderContainer(
                overrides: [
                  getMatchUseCaseProvider.overrideWith(
                    (ref) => getMatchUseCase,
                  ),
                  loadMatchUseCaseProvider.overrideWith(
                    (ref) => loadMatchUseCase,
                  ),
                ],
              );

              // make sure disposed container to not overflow into other tests, i guess...
              addTearDown(() {
                providerContaiuner.dispose();
              });

              // create a listener
              final listener =
                  _MockListener<AsyncValue<GetMatchControllerState>>();

              final getMatchControllerProviderInstance =
                  getMatchControllerProvider(
                matchId: match.id,
              );

              providerContaiuner.listen(
                getMatchControllerProviderInstance,
                listener,
                fireImmediately: true,
              );

              await Future.delayed(Duration.zero);

              verifyInOrder([
                () => listener(
                      null,
                      const AsyncValue<GetMatchControllerState>.loading(),
                    ),
                () => listener(
                      const AsyncValue<GetMatchControllerState>.loading(),
                      AsyncValue<GetMatchControllerState>.data(
                          GetMatchControllerState(
                        isRemoteFetchDone: false,
                        match: match,
                      )),
                    ),
                () => listener(
                      AsyncValue<GetMatchControllerState>.data(
                        GetMatchControllerState(
                          isRemoteFetchDone: false,
                          match: match,
                        ),
                      ),
                      AsyncValue<GetMatchControllerState>.data(
                        GetMatchControllerState(
                          isRemoteFetchDone: true,
                          match: match,
                        ),
                      ),
                    ),
              ]);
            },
          );
        },
      );

      // error state
    },
  );
}

class _MockGetMatchUseCase extends Mock implements GetMatchUseCase {}

class _MockLoadMatchUseCase extends Mock implements LoadMatchUseCase {}

// TODO this will just be a generic listener that we will monitor to verify state changes
class _MockListener<T> extends Mock {
  void call(T? previousState, T newState);
}
