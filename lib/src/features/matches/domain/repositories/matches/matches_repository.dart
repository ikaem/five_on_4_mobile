import 'package:five_on_4_mobile/src/features/matches/domain/models/match/match_model.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/values/match_create_data_value.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/values/player_match_models_overview_value.dart';

abstract interface class MatchesRepository {
  Future<int> createMatch({
    required MatchCreateDataValue matchData,
  });
  Future<int> loadMatch({
    required int matchId,
  });
  Future<MatchModel> getMatch({
    required int matchId,
  });

  Future<void> loadPlayerMatchesOverview({
    required int playerId,
  });

  Future<PlayerMatchModelsOverviewValue> getPlayerMatchesOverview({
    required int playerId,
  });

  // TODO deprecated - change with loadPlayerMatchesOverview
  Future<void> loadMyMatches(
      // TODO this should maybe accept id so that use case will retrieve user id from some auth repository
      // then we would have less functions in repositories
      );
  // TODO maybe not deprecated - but will need to be modified to be used as load more - and maybe just one function here
  Future<List<MatchModel>> getMyTodayMatches();
  Future<List<MatchModel>> getMyUpcomingMatches();
  Future<List<MatchModel>> getMyPastMatches();
}
