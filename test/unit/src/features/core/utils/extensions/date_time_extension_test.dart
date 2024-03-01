import 'package:five_on_4_mobile/src/features/core/utils/extensions/date_time_extension.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(
    "DateTimeExtension",
    () {
      group(".dayStart", () {
        test(
          "given a DateTime "
          "when .dayStart is called "
          "then should return a new DateTime with time set to start of the day",
          () {
            // setup

            // given
            final dateTime = DateTime(
              2021,
              1,
              1,
              12,
              30,
              11,
            );

            // when
            final result = dateTime.dayStart;

            // then
            expect(
              result,
              equals(
                DateTime(
                  2021,
                  1,
                  1,
                  0,
                  0,
                  0,
                ),
              ),
            );
          },
        );
      });
    },
  );
}
