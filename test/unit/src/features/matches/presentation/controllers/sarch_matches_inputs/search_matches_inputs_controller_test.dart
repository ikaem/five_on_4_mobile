import 'package:five_on_4_mobile/src/features/core/utils/inputs_validation/input_error.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/values/search_matches_input_args_value.dart';
import 'package:five_on_4_mobile/src/features/matches/presentation/controllers/sarch_matches_inputs/search_matches_inputs_controller.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("$SearchMatchesInputsController", () {
    group(".validatedMatchTitleStream", () {
      test(
        "given no value is added into the stream"
        "when listening to .validatedMatchTitleStream"
        "then should emit nothing",
        () async {
          // setup
          final controller = SearchMatchesInputsController();

          // given
          // nothing added to the stream

          // when / then
          expect(
            controller.validatedMatchTitleStream,
            emitsInOrder([]),
          );

          // cleanup
          addTearDown(() async {
            await controller.dispose();
          });
        },
      );

      test(
        "given a value is added into the stream"
        "when listening to .validatedMatchTitleStream"
        "then should emit the value",
        () async {
          // setup
          final controller = SearchMatchesInputsController();

          // given
          controller.onMatchTitleChanged("match title");

          // when / then
          expect(
            controller.validatedMatchTitleStream,
            emitsInOrder(["match title"]),
          );

          // then

          // cleanup
          addTearDown(() async {
            await controller.dispose();
          });
        },
      );

      test(
        "given an empty string is added into the stream"
        "when listening to .validatedMatchTitleStream"
        "then should emit expected error",
        () async {
          // setup
          final controller = SearchMatchesInputsController();

          // given
          controller.onMatchTitleChanged("");

          // when / then
          expect(
            controller.validatedMatchTitleStream,
            emitsError(InputError.empty),
          );

          // cleanup
          addTearDown(() async {
            await controller.dispose();
          });
        },
      );
    });

    group(".areInputsValidStream", () {
      test(
        "given all inputs are invalid"
        "when .areInputsValidStream is listened to"
        "then should emit expected event",
        () async {
          // setup
          final controller = SearchMatchesInputsController();

          // given
          controller.onMatchTitleChanged("");

          // when / then
          expect(
            controller.areInputsValidStream,
            emitsInOrder([false]),
          );

          // cleanup
          addTearDown(() async {
            await controller.dispose();
          });
        },
      );

      test(
        "given all inputs are valid"
        "when .areInputsValidStream is listened to"
        "then should emit expected event",
        () async {
          // setup
          final controller = SearchMatchesInputsController();

          // given
          controller.onMatchTitleChanged("match title");

          // when / then
          expect(
            controller.areInputsValidStream,
            emitsInOrder([true]),
          );

          // cleanup
          addTearDown(() async {
            await controller.dispose();
          });
        },
      );
    });

    group(".validatedSearchMatchesInputArgsValue", () {
      test(
        "given all inputs are invalid "
        "when .validatedSearchMatchesInputArgsValue is called"
        "then should return expected value",
        () async {
          // setup
          final controller = SearchMatchesInputsController();

// TODO what about null value*
          const matchTitle = "";

          // given
          controller.onMatchTitleChanged(matchTitle);

          // when / then
          expect(
            controller.validatedSearchMatchesInputArgsValue,
            isNull,
          );

          // cleanup
          addTearDown(() async {
            await controller.dispose();
          });
        },
      );

      test(
        "given all inputs are valid "
        "when .validatedSearchMatchesInputArgsValue is called"
        "then should return expected value",
        () async {
          // setup
          final controller = SearchMatchesInputsController();

          const matchTitle = "match title";

          // given
          controller.onMatchTitleChanged(matchTitle);

          // when / then
          expect(
              controller.validatedSearchMatchesInputArgsValue,
              equals(
                const SearchMatchesInputArgsValue(matchTitle: matchTitle),
              ));

          // cleanup
          addTearDown(() async {
            await controller.dispose();
          });
        },
      );
    });
  });
}
