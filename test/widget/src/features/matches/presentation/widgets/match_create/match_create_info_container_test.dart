import 'package:five_on_4_mobile/src/features/core/presentation/widgets/error_status.dart';
import 'package:five_on_4_mobile/src/features/core/presentation/widgets/loading_status.dart';
import 'package:five_on_4_mobile/src/features/matches/presentation/widgets/match_create/match_create_info.dart';
import 'package:five_on_4_mobile/src/features/matches/presentation/widgets/match_create/match_create_info_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(
    "MatchCreateTabOptionInfo",
    () {
      // TODO where should we test that we are redirected after match is created? In MatchCreateScreenView? Because the button is there?
      group(
        "Layout",
        () {
          testWidgets(
            "given 'isError' argument is true"
            "when widget is rendered"
            "then should show ErrorStatus widget with expected arguments",
            (widgetTester) async {
              // setup
              onRetry() async {}

              // given
              const isError = true;

              // when
              await widgetTester.pumpWidget(
                MaterialApp(
                  home: MatchCreateInfoContainer(
                    isError: isError,
                    isLoading: false,
                    onRetry: onRetry,
                    dateTimeStream: const Stream<DateTime>.empty(),
                    descriptionStream: const Stream<String>.empty(),
                    nameStream: const Stream<String>.empty(),
                    onDateTimeChanged: (DateTime? dateTime) {},
                    onDescriptionChanged: (String description) {},
                    onNameChanged: (String name) {},
                    locationStream: const Stream<String>.empty(),
                    onLocationChanged: (String location) {},
                  ),
                ),
              );

              // then
              final errorStatusFinder = find.byWidgetPredicate((widget) {
                if (widget is! ErrorStatus) return false;
                if (widget.message != "There was an issue creating match") {
                  return false;
                }
                if (widget.onRetry != onRetry) return false;

                return true;
              });

              expect(errorStatusFinder, findsOneWidget);

              // cleanup
            },
          );

          testWidgets(
            "given 'isLoading' argument is true"
            "when widget is rendered"
            "then should show LoadingStatus widget with expected arguments",
            (widgetTester) async {
              // given
              const isLoading = true;

              // when
              await widgetTester.pumpWidget(
                MaterialApp(
                  home: MatchCreateInfoContainer(
                    isError: false,
                    isLoading: isLoading,
                    onRetry: () async {},
                    dateTimeStream: const Stream<DateTime>.empty(),
                    descriptionStream: const Stream<String>.empty(),
                    nameStream: const Stream<String>.empty(),
                    onDateTimeChanged: (DateTime? dateTime) {},
                    onDescriptionChanged: (String description) {},
                    onNameChanged: (String name) {},
                    locationStream: const Stream<String>.empty(),
                    onLocationChanged: (String location) {},
                  ),
                ),
              );

              // then
              final loadingStatusFinder = find.byWidgetPredicate((widget) {
                if (widget is! LoadingStatus) return false;
                if (widget.message != "Creating match...") return false;

                return true;
              });

              expect(loadingStatusFinder, findsOneWidget);
            },
          );

          testWidgets(
            "given 'isError' and 'isLoading' arguments are false and rest of the arguments are provided"
            "when widget is rendered"
            "then should show MatchCreateInfo widget with expected arguments",
            (widgetTester) async {
              // given
              const isError = false;
              const isLoading = false;
              const nameStream = Stream<String>.empty();
              const dateTimeStream = Stream<DateTime>.empty();
              const descriptionStream = Stream<String>.empty();
              const locationStream = Stream<String>.empty();
              onRetry() async {}
              onDateTimeChanged(DateTime? dateTime) {}
              onDescriptionChanged(String description) {}
              onNameChanged(String name) {}
              onLocationChanged(String location) {}

              // when
              await widgetTester.pumpWidget(
                MaterialApp(
                  home: Scaffold(
                    body: MatchCreateInfoContainer(
                      isError: isError,
                      isLoading: isLoading,
                      onRetry: onRetry,
                      dateTimeStream: dateTimeStream,
                      descriptionStream: descriptionStream,
                      nameStream: nameStream,
                      locationStream: locationStream,
                      onDateTimeChanged: onDateTimeChanged,
                      onDescriptionChanged: onDescriptionChanged,
                      onNameChanged: onNameChanged,
                      onLocationChanged: onLocationChanged,
                    ),
                  ),
                ),
              );

              // then
              // TODO i coud also find state here from the container widget, and compare controllers from those states to controllers passe dto match create info
              final matchCreateInfoFinder =
                  find.byWidgetPredicate((Widget widget) {
                final localWidget = widget;
                if (localWidget is! MatchCreateInfo) return false;
                if (localWidget.nameStream != nameStream) return false;
                if (localWidget.dateTimeStream != dateTimeStream) return false;
                if (localWidget.descriptionStream != descriptionStream) {
                  return false;
                }
                if (localWidget.onNameChanged != onNameChanged) return false;
                if (localWidget.onDateTimeChanged != onDateTimeChanged) {
                  return false;
                }
                if (localWidget.onDescriptionChanged != onDescriptionChanged) {
                  return false;
                }

                return true;
              });

              expect(matchCreateInfoFinder, findsOneWidget);
            },
          );
        },
      );
    },
  );
}
