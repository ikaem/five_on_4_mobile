import 'package:five_on_4_mobile/src/features/matches/domain/use_cases/get_match/get_match_use_case.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/use_cases/get_match/provider/get_match_use_case_provider.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/use_cases/load_match/load_match_use_case.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/use_cases/load_match/provider/load_match_use_case_provider.dart';
import 'package:five_on_4_mobile/src/features/matches/presentation/screens/match_screen/match_screen.dart';
import 'package:five_on_4_mobile/src/features/matches/presentation/screens/match_screen/match_screen_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../../../utils/data/test_models.dart';
import '../../../../../../../utils/extensions/widget_tester_extension.dart';

void main() {
  final testMatch = getTestMatchModel();

  final getMatchUseCase = _MockGetMatchUseCase();
  final loadMatchUseCase = _MockLoadMatchUseCase();

  final riverpodOverrides = [
    getMatchUseCaseProvider.overrideWith(
      (ref) => getMatchUseCase,
    ),
    loadMatchUseCaseProvider.overrideWith(
      (ref) => loadMatchUseCase,
    ),
  ];

  setUpAll(
    () {
      when(
        () => getMatchUseCase(
          matchId: testMatch.id,
        ),
      ).thenAnswer(
        (_) async => testMatch,
      );
      when(
        () => loadMatchUseCase(
          matchId: testMatch.id,
        ),
      ).thenAnswer(
        (_) async => testMatch.id,
      );
    },
  );
  group(
    "MatchScreen",
    () {
      group(
        "Layout",
        () {
          testWidgets(
            "given nothing in particular"
            "when screen is rendered"
            "should show [MatchView] with expected arguments passed to it",
            (widgetTester) async {
              await widgetTester.pumpWithProviderScope(
                overrides: riverpodOverrides,
                widget: const MaterialApp(
                  home: MatchScreen(matchId: 1),
                ),
              );

              final matchViewFinder = find.byWidgetPredicate((widget) {
                if (widget is! MatchScreenView) return false;
                if (widget.matchId != testMatch.id) return false;

                return true;
              });

              expect(matchViewFinder, findsOneWidget);
            },
          );
        },
      );
    },
  );
}

class _MockGetMatchUseCase extends Mock implements GetMatchUseCase {}

class _MockLoadMatchUseCase extends Mock implements LoadMatchUseCase {}
