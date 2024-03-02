import 'package:five_on_4_mobile/src/features/matches/presentation/widgets/match_create/match_create_participants.dart';
import 'package:five_on_4_mobile/src/features/matches/presentation/widgets/match_create/match_create_participants_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';

import '../../../../../../../utils/data/test_models.dart';

void main() {
  group(
    "MatchCreateParticipantsContainer",
    () {
      group(
        "Layout",
        () {
          testWidgets(
            "give nothing in particular"
            "when widget is rendered"
            "should show expected widget",
            (widgetTester) async {
              final playersToInvite = getTestPlayersModels(count: 3);

              await mockNetworkImages(() async {
                await widgetTester.pumpWidget(
                  MaterialApp(
                    home: Scaffold(
                      // TODO both toggler and toggler option should be extracted
                      body: MatchCreateParticipantsContainer(
                        playersToInvite: playersToInvite,
                        isLoading: false,
                        isError: false,
                        onRetry: () async {},
                      ),
                    ),
                  ),
                );
              });
              final matchCreateParticipantsDataFinder = find.byWidgetPredicate(
                (widget) {
                  if (widget is! MatchCreateParticipants) return false;
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
