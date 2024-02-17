import 'package:five_on_4_mobile/src/features/matches/presentation/widgets/match/match_participants.dart';
import 'package:five_on_4_mobile/src/features/matches/presentation/widgets/match/match_participants_container.dart';
import 'package:five_on_4_mobile/src/features/players/models/player/player_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';

import '../../../../../../../utils/data/test_models.dart';

// TODO these tests are in a wrong folder - unit

void main() {
  group("MatchParticipantsContainer", () {
    group(
      "Layout",
      () {
        testWidgets(
          "given empty list of participants is provided"
          "when widget is rendered"
          "should show expected NO PARTICIPANTS text",
          (widgetTester) async {
            final participants = <PlayerModel>[];

// TODO need to test other fields too
            await widgetTester.pumpWidget(
              MaterialApp(
                home: MatchParticipantsContainer(
                  participants: participants,
                  isError: false,
                  isLoading: false,
                  isSyncing: false,
                ),
              ),
            );

            final noParticipantsText = find.text("No participants");
            final inviteOneText = find.text("Why not invite some?");

            expect(noParticipantsText, equals(findsOneWidget));
            expect(inviteOneText, equals(findsOneWidget));
          },
        );

        testWidgets(
          "given non-empty list of participants is provided"
          "when widget is rendered"
          "should show [MatchParticipants] widget with expected arguments",
          (widgetTester) async {
            final participants = getTestPlayersModels();

            await mockNetworkImages(() async {
              await widgetTester.pumpWidget(
                MaterialApp(
                  home: MatchParticipantsContainer(
                    participants: participants,
                    isError: false,
                    isLoading: false,
                    isSyncing: false,
                  ),
                ),
              );
            });

            final matchParticipatsFinder = find.byWidgetPredicate((widget) {
              if (widget is! MatchParticipants) {
                return false;
              }

              if (widget.participants != participants) {
                return false;
              }

              return true;
            });

            expect(matchParticipatsFinder, findsOneWidget);
          },
        );
      },
    );
  });
}
