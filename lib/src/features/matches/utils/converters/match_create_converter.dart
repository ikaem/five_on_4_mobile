import 'package:five_on_4_mobile/src/features/matches/domain/values/match_create_data_value.dart';
import 'package:five_on_4_mobile/src/features/matches/presentation/controllers/create_match/provider/create_match_controller.dart';

// TODO this needs to be tested
abstract class MatchCreateConverter {
  static MatchCreateDataValue valueFromArgsAndOrganizer({
    required CreateMatchArgs args,
    required String organizer,
  }) {
    return MatchCreateDataValue(
      description: args.description,
      location: args.location,
      organizer: organizer,
      invitedPlayers: args.playersForInvite,
      name: args.name,
    );
  }
}
