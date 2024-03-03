import 'package:five_on_4_mobile/src/features/matches/domain/values/match_create_data_value.dart';

List<MatchCreateDataValue> getTestMatchCreateValues({
  int count = 10,
  String namesPrefix = "test_",
}) {
  final matches = List<MatchCreateDataValue>.generate(
    count,
    (index) {
      return MatchCreateDataValue(
        name: "${namesPrefix}name$index",
        location: "${namesPrefix}location$index",
        organizer: "${namesPrefix}organizer$index",
        description: "${namesPrefix}description$index",
        dateTime:
            DateTime.now().add(Duration(hours: index)).millisecondsSinceEpoch,
        // TODO for now we will have this is empty
        invitedPlayers: const [],
      );
    },
  );

  return matches;
}
