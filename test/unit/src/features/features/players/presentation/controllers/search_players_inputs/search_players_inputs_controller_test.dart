import 'package:five_on_4_mobile/src/features/core/utils/inputs_validation/input_error.dart';
import 'package:five_on_4_mobile/src/features/players/domain/values/search_players_input_args_value.dart';
import 'package:five_on_4_mobile/src/features/players/presentation/controllers/search_players_input/search_players_input_controller.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(
    "$SearchPlayersInputsController",
    () {
      // TODO dont forget to test latest value getter
      group(".validatedNameTermInputsStream", () {
        test(
          "given no valie is added into the [.validatedNameTermInputsStream]"
          "when listening to [.validatedNameTermInputsStream]"
          "then should emit nothing",
          () async {
            // setup
            final controller = SearchPlayersInputsController();

            // given

            // when / then
            expect(
              controller.validatedNameTermStream,
              emitsInOrder([]),
            );

            // cleanup
            addTearDown(() async {
              await controller.dispose();
            });
          },
        );

        test(
          "given a value is added into the [.validatedNameTermInputsStream]"
          "when listening to [.validatedNameTermInputsStream]"
          "then should emit the value",
          () async {
            // setup
            final controller = SearchPlayersInputsController();

            // given
            controller.onNameTermChanged("name term");

            // when / then
            expect(
              controller.validatedNameTermStream,
              emitsInOrder(["name term"]),
            );

            // cleanup
            addTearDown(() async {
              await controller.dispose();
            });
          },
        );

        test(
          "given an empty string is added into the [.validatedNameTermInputsStream]"
          "when listening to [.validatedNameTermInputsStream]"
          "then should emit expected error",
          () async {
            // setup
            final controller = SearchPlayersInputsController();

            // given
            controller.onNameTermChanged("");

            // when / then
            expect(
              controller.validatedNameTermStream,
              emitsError(InputError.empty),
            );

            // cleanup
            addTearDown(() async {
              await controller.dispose();
            });
          },
        );
      });

      group(
        ".areInputsValidStream",
        () {
          test(
            "given all inputs are invalid"
            "when listening to [.areInputsValidStream]"
            "then should emit expected value",
            () async {
              // setup
              final controller = SearchPlayersInputsController();

              // given
              controller.onNameTermChanged("");

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
            "when listening to [.areInputsValidStream]"
            "then should emit expected value",
            () async {
              // setup
              final controller = SearchPlayersInputsController();

              // given
              controller.onNameTermChanged("name term");

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
        },
      );

      group(
        ".validatedSearchPlayersInputArgsValue",
        () {
          test(
            "given all inputs are invalid"
            "when get value from [.validatedSearchPlayersInputArgsValue]"
            "then should get expected value",
            () async {
              // setup
              final controller = SearchPlayersInputsController();

              // given
              controller.onNameTermChanged("");

              // when / then
              expect(
                controller.validatedSearchPlayersInputArgsValue,
                isNull,
              );

              // cleanup
              addTearDown(() async {
                await controller.dispose();
              });
            },
          );

          test(
            "given all inputs are valid"
            "when get value from [.validatedSearchPlayersInputArgsValue]"
            "then should get expected value",
            () async {
              // setup
              final controller = SearchPlayersInputsController();

              // given
              controller.onNameTermChanged("name term");

              // when / then
              expect(
                controller.validatedSearchPlayersInputArgsValue,
                equals(
                  const SearchPlayersInputArgsValue(nameTerm: "name term"),
                ),
              );

              // cleanup
              addTearDown(() async {
                await controller.dispose();
              });
            },
          );
        },
      );

      group(
        ".latestNameTermValue",
        () {
          // given no value has been added
        },
      );
    },
  );
}
