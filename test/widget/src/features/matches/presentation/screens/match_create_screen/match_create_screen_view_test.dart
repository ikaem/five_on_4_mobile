import 'package:five_on_4_mobile/src/features/core/presentation/widgets/tab_toggler/tab_toggler.dart';
import 'package:five_on_4_mobile/src/features/matches/presentation/widgets/match_create/match_create_info_container.dart';
import 'package:five_on_4_mobile/src/features/matches/presentation/widgets/match_create/match_create_participants_container.dart';
import 'package:five_on_4_mobile/src/features/matches/presentation/screens/match_create_screen/match_create_screen_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../../../utils/extensions/widget_tester_extension.dart';

void main() {
  group(
    "$MatchCreateScreenView",
    () {
      group(
        "Layout",
        () {
          testWidgets(
            "given MatchCreateScreenView dependencies are provided "
            "when the widget is rendered "
            "then should should show a [TabToggler] with expected arguments",
            (tester) async {
              // setup

              // given

              // when
              await tester.pumpWithProviderScope(
                widget: const MaterialApp(
                  home: Scaffold(
                    body: MatchCreateScreenView(),
                  ),
                ),
              );

              // then
              final tabTogglerFinder = _findTabToggler();
              expect(tabTogglerFinder, findsOneWidget);

              // cleanup
            },
          );

          // TODO use MatchScreenViewTest as a reference
          // testWidgets(
          //   "given nothing in particular"
          //   "when widget is rendered"
          //   "should show a [TabToggler] with expected arguments",
          //   (widgetTester) async {
          //     await widgetTester.pumpWidget(
          //       const MaterialApp(
          //         home: Scaffold(
          //           // TODO match view will need some arguments eventually
          //           body: MatchCreateScreenView(),
          //         ),
          //       ),
          //     );

          //     final tabTogglerFinder = find.byWidgetPredicate((widget) {
          //       if (widget is! TabToggler) return false;
          //       if (widget.options.length != 2) return false;

          //       final option1 = widget.options[0];
          //       final option2 = widget.options[1];

          //       final option1Title = option1.title;
          //       final option2Title = option2.title;

          //       if (option1Title != "Info") return false;
          //       if (option2Title != "Participants") return false;

          //       final option1Child = option1.child;
          //       final option2Child = option2.child;

          //       if (option1Child is! MatchCreateInfoContainer) return false;
          //       if (option2Child is! MatchCreateParticipantsContainer) {
          //         return false;
          //       }

          //       // TODO will need chec more arguments here

          //       return true;
          //     });

          //     expect(tabTogglerFinder, findsOneWidget);
          //   },
          // );
        },
      );
    },
  );
}

Finder _findTabToggler({
  bool Function({
    required MatchCreateInfoContainer infoContainer,
    required MatchCreateParticipantsContainer participantsContainer,
  })? propertyChecker,
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

    if (option1Child is! MatchCreateInfoContainer) return false;
    if (option2Child is! MatchCreateParticipantsContainer) {
      return false;
    }

    if (propertyChecker == null) return true;

    final doChildrenPropertiesMatch = propertyChecker(
      infoContainer: option1Child,
      participantsContainer: option2Child,
    );
    return doChildrenPropertiesMatch;
  });

  return tabTogglerFinder;
}
