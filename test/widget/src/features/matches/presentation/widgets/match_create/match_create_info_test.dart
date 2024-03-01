import 'package:five_on_4_mobile/src/features/core/presentation/widgets/inputs/streamed_date_time_field.dart';
import 'package:five_on_4_mobile/src/features/core/presentation/widgets/inputs/streamed_text_field.dart';
import 'package:five_on_4_mobile/src/features/core/utils/extensions/date_time_extension.dart';
import 'package:five_on_4_mobile/src/features/core/utils/helpers/date_time_input_on_tap_setter.dart';
import 'package:five_on_4_mobile/src/features/matches/presentation/widgets/match_create/match_create_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  setUpAll(
    () {
      registerFallbackValue(_FakeBuildContext());
    },
  );
  group(
    "MatchCreateInfo",
    () {
      // TODO test logic here?
      // TODO or just test that correct streamed text is shown, and trust tests in streamed_text_field_test.dart
      group(
        "Layout",
        () {
          late TextEditingController genericTextController;
          setUp(() {
            genericTextController = TextEditingController();
          });

          tearDown(() {
            genericTextController.dispose();
          });

          testWidgets(
            "given name-related arguments are provided"
            "when widget is rendered"
            "should show expected StreamedTextField for 'Match Name' input",
            (widgetTester) async {
              const stream = Stream<String>.empty();
              final textEditingController = TextEditingController();
              onChangedCallback(String value) {}

              await widgetTester.pumpWidget(
                MaterialApp(
                  home: Scaffold(
                    body: MatchCreateInfo(
                      nameController: textEditingController,
                      onNameChanged: onChangedCallback,
                      nameStream: stream,
                      // TODO temp
                      dateTimeController: genericTextController,
                      onDateTimeChanged: (value) {},
                      dateTimeStream: const Stream<DateTime>.empty(),
                    ),
                  ),
                ),
              );

              final streamedMatchNameTextFieldFinder = find.byWidgetPredicate(
                (widget) {
                  if (widget is! StreamedTextField) return false;
                  if (widget.label != "Match Name") return false;
                  if (widget.textController != textEditingController) {
                    return false;
                  }
                  if (widget.onChanged != onChangedCallback) return false;
                  if (widget.stream != stream) return false;

                  return true;
                },
              );

              expect(streamedMatchNameTextFieldFinder, findsOneWidget);

              addTearDown(() {
                textEditingController.dispose();
              });
            },
          );

          testWidgets(
            "given dateTime-related arguments are provided"
            "when widget is rendered"
            "should show expected 'Match Date & Time' TextField input",
            (widgetTester) async {
              // given
              const stream = Stream<DateTime>.empty();
              final textEditingController = TextEditingController();
              onChangedCallback(DateTime? value) {}

              // when
              await widgetTester.pumpWidget(
                MaterialApp(
                  home: Scaffold(
                    body: MatchCreateInfo(
                      nameController: genericTextController,
                      onNameChanged: (value) {},
                      nameStream: Stream.fromIterable([""]),
                      dateTimeController: textEditingController,
                      onDateTimeChanged: onChangedCallback,
                      dateTimeStream: stream,
                    ),
                  ),
                ),
              );

              // then
              final expectedOnTapSetter = DateTimeInputOnTapSetter(
                initiallySelectedDate: DateTime.now().dayStart,
                fromDate: DateTime.now().dayStart,
                toDate: DateTime.now().add(const Duration(days: 365)).dayStart,
                onDateTimeChanged: onChangedCallback,
                textController: textEditingController,
              );

              final streamedMatchDateTimeFieldFinder = find.byWidgetPredicate(
                (widget) {
                  if (widget is! StreamedDateTimeField) return false;
                  if (widget.label != "Match Date & Time") return false;
                  if (widget.stream != stream) return false;
                  if (widget.onTapSetter != expectedOnTapSetter) return false;

                  return true;
                },
              );

              expect(streamedMatchDateTimeFieldFinder, findsOneWidget);

              addTearDown(() {
                textEditingController.dispose();
              });
            },
          );

          testWidgets(
            "given nothing in particular"
            "when widget is rendered"
            "should show expected 'MATCH DESCRIPTION' TextField input",
            (widgetTester) async {
              // TODO create mock stream
              // final stream = _MockStream();
              // // TODO create mock controller
              // final textEditingController = _MockTextEditingController();
              // TODO create mock on changed
              final onChangedCallback = _MockOnChangedCallbackWrapper();

              await widgetTester.pumpWidget(
                MaterialApp(
                  home: Scaffold(
                    body: MatchCreateInfo(
                      nameController: genericTextController,
                      onNameChanged: onChangedCallback,
                      nameStream: Stream.fromIterable([""]),
                      // TODO temp
                      dateTimeController: genericTextController,
                      onDateTimeChanged: (value) {},
                      dateTimeStream: const Stream<DateTime>.empty(),
                    ),
                  ),
                ),
              );

              final matchDescriptionTextFieldFinder = find.byWidgetPredicate(
                (widget) {
                  if (widget is! TextField) return false;
                  if (widget.decoration?.labelText != "MATCH DESCRIPTION") {
                    return false;
                  }
                  if (widget.minLines != 5) return false;
                  if (widget.maxLines != 5) return false;

                  return true;
                },
              );

              expect(matchDescriptionTextFieldFinder, findsOneWidget);
            },
          );
          // TODO should do interaction test to make sure that time picker is shown
        },
      );
    },
  );
}

class _MockTextEditingController extends Mock
    implements TextEditingController {}

class _MockOnChangedCallbackWrapper extends Mock {
  void call(String value);
}

// TODO we could also make this generic
class _MockStream extends Mock implements Stream<String> {
  Stream<String> streamFunc() {
    return Stream.fromIterable(["Some value"]);
  }

  Stream<String> streamFuncGenerator() async* {
    yield "Some value";
  }
}

class _FakeBuildContext extends Fake implements BuildContext {}
