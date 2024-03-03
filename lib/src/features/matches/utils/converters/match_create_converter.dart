import 'package:five_on_4_mobile/src/features/matches/domain/values/match_create_data_value.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/values/match_create_input_args.dart';

// TODO this needs to be tested
abstract class MatchCreateConverter {
  static MatchCreateDataValue valueFromArgsAndOrganizer({
    required MatchCreateInputArgs args,
    required String organizer,
  }) {
    return MatchCreateDataValue(
      description: args.description,
      location: args.location,
      organizer: organizer,
      invitedPlayers: args.playersForInvite,
      name: args.name,
      dateTime: args.dateTime,
    );
  }
}
