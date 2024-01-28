import 'package:five_on_4_mobile/src/features/matches/presentation/widgets/match_create/match_create_participants_data.dart';
import 'package:five_on_4_mobile/src/features/matches/presentation/widgets/match_create/match_create_tab_option_participants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';

import '../../../../../../../utils/data/test_models.dart';

void main() {
  group(
    "MatchCreateTabOptionParticipants",
    () {
      group(
        "Layout",
        () {
          testWidgets(
            "give nothing in particular"
            "when widget is rendered"
            "should show expected widget",
            (widgetTester) async {
              final playersToInvite = getTestPlayers(count: 3);

              await mockNetworkImages(() async {
                await widgetTester.pumpWidget(
                  MaterialApp(
                    home: Scaffold(
                      // TODO both toggler and toggler option should be extracted
                      body: MatchCreateTabOptionParticipants(
                        playersToInvite: playersToInvite,
                      ),
                    ),
                  ),
                );
              });
              final matchCreateParticipantsDataFinder = find.byWidgetPredicate(
                (widget) {
                  if (widget is! MatchCreateParticipantsData) return false;
                  if (widget.playersToInvite != playersToInvite) return false;
                  // TODO there will be more checks here when we pass arguments to widget

                  return true;
                },
              );

              expect(matchCreateParticipantsDataFinder, findsOneWidget);
            },
          );
        },
      );
    },
  );
}
