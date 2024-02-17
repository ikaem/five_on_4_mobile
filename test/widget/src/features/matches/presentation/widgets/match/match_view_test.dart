import 'package:five_on_4_mobile/src/features/core/presentation/widgets/tab_toggler/tab_toggler.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/models/match/match_model.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/use_cases/get_match/get_match_use_case.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/use_cases/get_match/provider/get_match_use_case_provider.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/use_cases/load_match/load_match_use_case.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/use_cases/load_match/provider/load_match_use_case_provider.dart';
import 'package:five_on_4_mobile/src/features/matches/presentation/widgets/match/match_info_container.dart';
import 'package:five_on_4_mobile/src/features/matches/presentation/widgets/match/match_participants_container.dart';
import 'package:five_on_4_mobile/src/features/matches/presentation/widgets/match/match_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../../../utils/data/test_models.dart';
import '../../../../../../../utils/extensions/widget_tester_extension.dart';

void main() {
  final testPlayers = getTestPlayersModels();
  final testMatch = getTestMatchModel(arrivingPlayers: testPlayers);

  final getMatchUseCase = _MockGetMatchUseCase();
  final loadMatchUseCase = _MockLoadMatchUseCase();

  final overrides = [
    getMatchUseCaseProvider.overrideWith((ref) => getMatchUseCase),
    loadMatchUseCaseProvider.overrideWith((ref) => loadMatchUseCase),
  ];

  tearDown(() {
    reset(getMatchUseCase);
    reset(loadMatchUseCase);
  });

  group(
    "MatchView",
    () {
      group(
        "Layout",
        () {
          testWidgets(
            "given nothing in particular"
            "when widget is rendered"
            "should show a [TabToggler] with expected arguments",
            (widgetTester) async {
              const matchId = 1;

              _stubGetMatchUseCases(
                getMatchUseCase: getMatchUseCase,
                loadMatchUseCase: loadMatchUseCase,
                matchId: matchId,
                match: testMatch,
              );

              await widgetTester.pumpWithProviderScope(
                widget: const MaterialApp(
                  home: Scaffold(
                    body: MatchView(
                      matchId: matchId,
                    ),
                  ),
                ),
                overrides: overrides,
              );

              final tabTogglerFinder = _findTabToggler();

              expect(tabTogglerFinder, findsOneWidget);
            },
          );
        },
      );
    },
  );
}

class _MockGetMatchUseCase extends Mock implements GetMatchUseCase {}

class _MockLoadMatchUseCase extends Mock implements LoadMatchUseCase {}

void _stubGetMatchUseCases({
  required GetMatchUseCase getMatchUseCase,
  required LoadMatchUseCase loadMatchUseCase,
  required int matchId,
  required MatchModel match,
}) {
  when(
    () => getMatchUseCase(
      matchId: any(named: "matchId"),
    ),
  ).thenAnswer((_) async => match);

  when(
    () => loadMatchUseCase(
      matchId: any(
        named: "matchId",
      ),
    ),
  ).thenAnswer(
    (_) async => matchId,
  );
}

Finder _findTabToggler({
  bool Function()? propertyChecker,
}) {
  final tabTogglerFinder = find.byWidgetPredicate((widget) {
    if (widget is! TabToggler) return false;
    if (widget.options.length != 2) return false;

    final option1 = widget.options[0];
    final option2 = widget.options[1];

    final option1Title = option1.title;
    final option2Title = option2.title;

    if (option1Title != "Info") return false;
    if (option2Title != "Participants") return false;

    final option1Child = option1.child;
    final option2Child = option2.child;

    if (option1Child is! MatchInfoContainer) return false;
    if (option2Child is! MatchParticipantsContainer) return false;

    if (propertyChecker == null) return true;

    final doChildrenPropertiesMatch = propertyChecker();
    return doChildrenPropertiesMatch;

    // final option1ChildMatch = option1Child.match;
    // final option2ChildParticipants = option2Child.participants;

    // if (option1ChildMatch != testMatch) return false;
    // if (option2ChildParticipants != testPlayers) return false;
  });

  return tabTogglerFinder;
}
