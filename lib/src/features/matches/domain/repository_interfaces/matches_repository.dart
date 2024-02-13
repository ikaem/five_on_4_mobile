import 'package:five_on_4_mobile/src/features/matches/domain/models/match/match_model.dart';

abstract interface class MatchesRepository {
  Future<void> loadMyMatches();
  Future<List<MatchModel>> getMyTodayMatches();
  Future<List<MatchModel>> getMyUpcomingMatches();
  Future<List<MatchModel>> getMyPastMatches();
}
