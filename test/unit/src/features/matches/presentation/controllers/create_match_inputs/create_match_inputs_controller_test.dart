import 'package:five_on_4_mobile/src/features/core/utils/inputs_validation/input_error.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/values/match_create_input_args.dart';
import 'package:five_on_4_mobile/src/features/matches/presentation/controllers/create_match_inputs/create_match_inputs_controller.dart';
import 'package:flutter_test/flutter_test.dart';

// TODO testing streams https://medium.com/nerd-for-tech/unit-testing-streams-in-dart-flutter-6ed72c19f761
// https://codewithandrea.com/articles/async-tests-streams-flutter/

void main() {
  group(
    "$CreateMatchInputsController",
    () {
      group(
        ".validatedNameStream",
        () {
          test(
            "given no value is added into the stream "
            "when listen '.validatedNameStream' "
            "then should emit nothing",
            () async {
              final controller = CreateMatchInputsController();

              // Given
              // Nothing added to the stream

              // Then / When
              expect(
                controller.validatedNameStream,
                emitsInOrder([]),
              );

              addTearDown(
                () async {
                  await controller.dispose();
                },
              );
            },
          );

          test(
            "given a value is added into the stream "
            "when listen '.validatedNameStream' "
            "then should emit the value",
            () async {
              final controller = CreateMatchInputsController();

              // Given
              controller.onNameChanged("Hello");

              // Then / When
              expect(
                controller.validatedNameStream,
                emitsInOrder(
                  [
                    "Hello",
                  ],
                ),
              );

              addTearDown(
                () async {
                  await controller.dispose();
                },
              );
            },
          );

          test(
            "given an invalid value is added into the stream "
            "when listen '.validatedNameStream' "
            "then should emit expected error",
            () async {
              final controller = CreateMatchInputsController();

              // Given
              controller.onNameChanged("");

              // Then / When
              expect(
                controller.validatedNameStream,
                emitsInOrder(
                  [
                    emitsError(InputError.empty),
                  ],
                ),
              );

              addTearDown(
                () async {
                  await controller.dispose();
                },
              );
            },
          );
        },
      );

      group(
        ".validatedLocationStream",
        () {
          test(
            "given no value is added into the stream "
            "when listen '.validatedLocationStream' "
            "then should emit nothing",
            () async {
              final controller = CreateMatchInputsController();

              // Given
              // Nothing added to the stream

              // Then / When
              expect(
                controller.validatedLocationStream,
                emitsInOrder([]),
              );

              addTearDown(
                () async {
                  await controller.dispose();
                },
              );
            },
          );

          test(
            "given a value is added into the stream "
            "when listen '.validatedLocationStream' "
            "then should emit the value",
            () async {
              final controller = CreateMatchInputsController();

              // Given
              controller.onLocationChanged("Hello");

              // Then / When
              expect(
                controller.validatedLocationStream,
                emitsInOrder(
                  [
                    "Hello",
                  ],
                ),
              );

              addTearDown(
                () async {
                  await controller.dispose();
                },
              );
            },
          );

          test(
            "given an invalid value is added into the stream "
            "when listen '.validatedLocationStream' "
            "then should emit expected error",
            () async {
              final controller = CreateMatchInputsController();

              // Given
              controller.onLocationChanged("");

              // Then / When
              expect(
                controller.validatedLocationStream,
                emitsInOrder(
                  [
                    emitsError(InputError.empty),
                  ],
                ),
              );

              addTearDown(
                () async {
                  await controller.dispose();
                },
              );
            },
          );
        },
      );

      group(
        ".validatedDescriptionStream",
        () {
          test(
            "given no value is added into the stream "
            "when listen '.validatedDescriptionStream' "
            "then should emit nothing",
            () async {
              final controller = CreateMatchInputsController();

              // Given
              // Nothing added to the stream

              // Then / When
              expect(
                controller.validatedDescriptionStream,
                emitsInOrder([]),
              );

              addTearDown(
                () async {
                  await controller.dispose();
                },
              );
            },
          );

          test(
            "given a value is added into the stream "
            "when listen '.validatedDescriptionStream' "
            "then should emit the value",
            () async {
              final controller = CreateMatchInputsController();

              // Given
              controller.onDescriptionChanged("Hello");

              // Then / When
              expect(
                controller.validatedDescriptionStream,
                emitsInOrder(
                  [
                    "Hello",
                  ],
                ),
              );

              addTearDown(
                () async {
                  await controller.dispose();
                },
              );
            },
          );

          test(
            "given an empty string value is added into the stream "
            "when listen '.validatedDescriptionStream' "
            "then should NOT emit error",
            () async {
              final controller = CreateMatchInputsController();

              // Given
              controller.onDescriptionChanged("");
              // controller.validatedDateTimeStream.

              // Then / When
              expect(
                controller.validatedDescriptionStream,
                neverEmits(equals(InputError.empty)),
              );

              // TODO force emit done to make sure neverEmits is triggered
              await controller.dispose();
            },
          );
        },
      );

      group(
        "validatedDateTimeStream",
        () {
          test(
            "given no value is added into the stream "
            "when listen '.validatedDateTimeStream' "
            "then should emit nothing",
            () {
              final controller = CreateMatchInputsController();

              // Given
              // Nothing added to the stream

              // Then / When
              expect(
                controller.validatedDateTimeStream,
                emitsInOrder([]),
              );

              addTearDown(
                () async {
                  await controller.dispose();
                },
              );
            },
          );

          test(
            "given a valid value is added into the stream "
            "when listen '.validatedDateTimeStream' "
            "then should emit the value",
            () {
              final controller = CreateMatchInputsController();

              // Given
              final value = DateTime.now().add(const Duration(days: 1));
              controller.onDateTimeChanged(value);

              // Then / When
              expect(
                controller.validatedDateTimeStream,
                emitsInOrder(
                  [
                    value,
                  ],
                ),
              );

              addTearDown(
                () async {
                  await controller.dispose();
                },
              );
            },
          );

          test(
            "given a past value is added into the stream "
            "when listen '.validatedDateTimeStream' "
            "then should emit expected error",
            () {
              final controller = CreateMatchInputsController();

              // Given
              final value = DateTime.now().subtract(const Duration(days: 1));
              controller.onDateTimeChanged(value);

              // Then / When
              expect(
                controller.validatedDateTimeStream,
                emitsInOrder(
                  [
                    emitsError(InputError.invalid),
                  ],
                ),
              );

              addTearDown(
                () async {
                  await controller.dispose();
                },
              );
            },
          );
        },
      );

      group(
        "validatedPlayersForInviteStream",
        () {
          test(
            "given no value is added into the stream "
            "when listen '.validatedPlayersForInviteStream' "
            "then should emit nothing",
            () {
              final controller = CreateMatchInputsController();

              // Given
              // Nothing added to the stream

              // Then / When
              expect(
                controller.validatedPlayersForInviteStream,
                emitsInOrder([]),
              );

              addTearDown(
                () async {
                  await controller.dispose();
                },
              );
            },
          );

          test(
            "given a valid value is added into the stream "
            "when listen '.validatedPlayersForInviteStream' "
            "then should emit the value",
            () {
              final controller = CreateMatchInputsController();

              // Given
              const value = 1;
              controller.onPlayersForInviteChanged(value);

              // Then / When
              expect(
                controller.validatedPlayersForInviteStream,
                emitsInOrder(
                  [
                    [value],
                  ],
                ),
              );

              addTearDown(
                () async {
                  await controller.dispose();
                },
              );
            },
          );
        },
      );

      group(
        ".validatedMatchCreateInputArgs",
        () {
          test(
            "given all inputs are valid "
            "when call '.validatedMatchCreateInputArgs' "
            "then should return the expected value",
            () {
              final controller = CreateMatchInputsController();

              const name = "Name";
              const location = "Location";
              const description = "Description";
              final dateTime = DateTime.now().add(const Duration(days: 1));
              const playerForInvite = 1;

              // Given
              controller.onNameChanged(name);
              controller.onLocationChanged(location);
              controller.onDescriptionChanged(description);
              controller.onDateTimeChanged(dateTime);
              controller.onPlayersForInviteChanged(playerForInvite);

              // Then / When
              expect(
                  controller.validatedMatchCreateInputArgs,
                  equals(
                    const MatchCreateInputArgs(
                      name: name,
                      location: location,
                      description: description,
                      // dateTime: dateTime,
                      playersForInvite: [playerForInvite],
                    ),
                  ));

              addTearDown(
                () async {
                  await controller.dispose();
                },
              );
            },
          );

          test(
            "given all inputs are invalid "
            "when call '.validatedMatchCreateInputArgs' "
            "then should return null",
            () {
              final controller = CreateMatchInputsController();

              // Given
              controller.onNameChanged("");
              controller.onLocationChanged("");
              controller.onDescriptionChanged("");
              controller.onDateTimeChanged(
                  DateTime.now().subtract(const Duration(days: 1)));
              controller.onPlayersForInviteChanged(0);

              // Then / When
              expect(
                controller.validatedMatchCreateInputArgs,
                isNull,
              );

              addTearDown(
                () async {
                  await controller.dispose();
                },
              );
            },
          );
        },
      );

      group(
        ".areInputsValidStream",
        () {
          test(
            "given all inputs are valid "
            "when listen '.areInputsValidStream' "
            "then should emit expected true event ",
            () {
              final controller = CreateMatchInputsController();

              // Given
              controller.onNameChanged("Name");
              controller.onLocationChanged("Location");
              controller.onDescriptionChanged("Description");
              controller.onDateTimeChanged(
                  DateTime.now().add(const Duration(days: 1)));
              controller.onPlayersForInviteChanged(1);

              // Then / When
              expect(
                controller.areInputsValidStream,
                emitsInOrder(
                  [
                    true,
                  ],
                ),
              );

              addTearDown(
                () async {
                  await controller.dispose();
                },
              );
            },
          );

          test(
            "given all inputs are invalid "
            "when listen '.areInputsValidStream' "
            "then should emit expected false event ",
            () async {
              final controller = CreateMatchInputsController();

              // Given
              controller.onNameChanged("");
              controller.onLocationChanged("");
              controller.onDescriptionChanged("");
              controller.onDateTimeChanged(
                  DateTime.now().subtract(const Duration(days: 1)));
              controller.onPlayersForInviteChanged(0);

              // Then / When
              expect(
                controller.areInputsValidStream,
                emitsInOrder(
                  [
                    false,
                  ],
                ),
              );

              addTearDown(
                () async {
                  await controller.dispose();
                },
              );
            },
          );

          test(
            "given all inputs BUT ONE are valid "
            "when listen '.areInputsValidStream' "
            "then should emit expected false event ",
            () {
              final controller = CreateMatchInputsController();

              // Given
              controller.onNameChanged("Name");
              controller.onLocationChanged("");
              controller.onDescriptionChanged("Description");
              controller.onDateTimeChanged(
                  DateTime.now().add(const Duration(days: 1)));
              controller.onPlayersForInviteChanged(1);

              // Then / When
              expect(
                controller.areInputsValidStream,
                emitsInOrder(
                  [
                    false,
                  ],
                ),
              );

              addTearDown(
                () async {
                  await controller.dispose();
                },
              );
            },
          );
        },
      );
    },
  );
}
