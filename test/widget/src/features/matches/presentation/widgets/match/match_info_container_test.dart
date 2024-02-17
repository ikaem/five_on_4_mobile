import 'package:five_on_4_mobile/src/features/core/presentation/widgets/error_status.dart';
import 'package:five_on_4_mobile/src/features/core/presentation/widgets/loading_status.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/models/match/match_model.dart';
import 'package:five_on_4_mobile/src/features/matches/presentation/widgets/match/match_info.dart';
import 'package:five_on_4_mobile/src/features/matches/presentation/widgets/match/match_info_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../../../utils/data/test_models.dart';

void main() {
  final match = getTestMatchesModels(count: 1).first;
  group(
    "MatchInfoContainer",
    () {
      group(
        // TODO will need to test other stuff too - when fields
        "Layout",
        () {
          testWidgets(
            "given 'isError' argument is set to true "
            "when widget is rendered"
            "then should show ErrorStatus widget with expected arguments",
            (widgetTester) async {
              const isError = true;
              onRetry() async {
                print("retry");
              }

              await widgetTester.pumpWidget(
                MaterialApp(
                  home: MatchInfoContainer(
                    match: match,
                    isError: isError,
                    isLoading: false,
                    isSyncing: false,
                    onRetry: onRetry,
                  ),
                ),
              );

              final errorStatusFinder = find.byWidgetPredicate((widget) {
                if (widget is! ErrorStatus) return false;
                if (widget.message != "There was an issue retrieving match") {
                  return false;
                }
                if (widget.onRetry != onRetry) return false;

                return true;
              });

              expect(errorStatusFinder, findsOneWidget);
            },
          );
          testWidgets(
            "given 'isLoading' argument is set to true "
            "when widget is rendered"
            "then should show LoadingStatus widget with expected arguments",
            (widgetTester) async {
              const isLoading = true;
              await widgetTester.pumpWidget(
                MaterialApp(
                  home: MatchInfoContainer(
                    match: match,
                    isError: false,
                    isLoading: isLoading,
                    isSyncing: false,
                    onRetry: () async {},
                  ),
                ),
              );

              final circularLoadingStatusFinder =
                  find.byWidgetPredicate((widget) {
                if (widget is! LoadingStatus) return false;
                if (widget.isLinear) return false;
                if (widget.message != "Loading match...") return false;

                return true;
              });

              expect(circularLoadingStatusFinder, findsOneWidget);
            },
          );

          testWidgets(
            "given 'isSyncing' argument is set to true "
            "when widget is rendered"
            "then should show LoadingStatus widget with expected arguments",
            (widgetTester) async {
              const isSyncing = true;
              await widgetTester.pumpWidget(
                MaterialApp(
                  home: MatchInfoContainer(
                    match: match,
                    isError: false,
                    isLoading: false,
                    isSyncing: isSyncing,
                    onRetry: () async {},
                  ),
                ),
              );

              final circularLoadingStatusFinder =
                  find.byWidgetPredicate((widget) {
                if (widget is! LoadingStatus) return false;
                if (!widget.isLinear) return false;
                if (widget.message != "Synchronizing with remote data...") {
                  return false;
                }

                return true;
              });

              expect(circularLoadingStatusFinder, findsOneWidget);
            },
          );

          testWidgets(
            "given valid match argument is provided "
            "when widget is rendered"
            "should render expected widget",
            (widgetTester) async {
              await widgetTester.pumpWidget(
                MaterialApp(
                  home: MatchInfoContainer(
                    match: match,
                    isError: false,
                    isLoading: false,
                    isSyncing: false,
                    onRetry: () async {},
                  ),
                ),
              );

              final matchInfo = find.byWidgetPredicate((widget) {
                // TODO extract this to function if needed in future
                if (widget is! MatchInfo) return false;
                if (widget.arrivingPlayersNumber !=
                    match.arrivingPlayers.length) {
                  return false;
                }
                if (widget.date != match.date.toString()) {
                  return false;
                }
                if (widget.dayName != "dayName") {
                  return false;
                }
                if (widget.time != "time") {
                  return false;
                }
                if (widget.title != match.name) {
                  return false;
                }
                if (widget.location != match.location) {
                  return false;
                }
                if (widget.organizer != match.organizer) {
                  return false;
                }

                return true;
              });

              expect(matchInfo, findsOneWidget);
            },
          );
        },
      );
    },
  );
}
