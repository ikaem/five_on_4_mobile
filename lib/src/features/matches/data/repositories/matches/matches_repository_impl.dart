import 'package:five_on_4_mobile/src/features/auth/data/data_sources/auth_status/auth_status_data_source.dart';
import 'package:five_on_4_mobile/src/features/auth/domain/exceptions/auth_exceptions.dart';
import 'package:five_on_4_mobile/src/features/matches/data/data_sources/matches_local/matches_local_data_source.dart';
import 'package:five_on_4_mobile/src/features/matches/data/data_sources/matches_remote/matches_remote_data_source.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/models/match/match_model.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/repository_interfaces/matches_repository.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/values/match_create_data_value.dart';
import 'package:five_on_4_mobile/src/features/matches/utils/converters/matches_converter.dart';

class MatchesRepositoryImpl implements MatchesRepository {
  const MatchesRepositoryImpl({
    required MatchesLocalDataSource matchesLocalDataSource,
    required MatchesRemoteDataSource matchesRemoteDataSource,
    required AuthStatusDataSource authStatusDataSource,
  })  : _matchesLocalDataSource = matchesLocalDataSource,
        _matchesRemoteDataSource = matchesRemoteDataSource,
        _authStatusDataSource = authStatusDataSource;

  final MatchesLocalDataSource _matchesLocalDataSource;
  final MatchesRemoteDataSource _matchesRemoteDataSource;
  final AuthStatusDataSource _authStatusDataSource;

  @override
  Future<void> loadMyMatches() async {
    final matchesRemote =
        await _matchesRemoteDataSource.getPlayerInitialMatches();

    final matchesLocal = MatchesConverter.fromRemoteEntitiesToLocalEntities(
      matchesRemote: matchesRemote,
    );

    await _matchesLocalDataSource.saveMatches(matches: matchesLocal);
  }

  @override
  Future<List<MatchModel>> getMyTodayMatches() async {
    // TODO useCases could also possibly get playerId and then ping some generic fucntions inside the repository
    final playerId = _authStatusDataSource.playerId;
    if (playerId == null) {
      // TODO responsible controller here should have access to logoutusecase, and use it to logout
      throw const AuthNotLoggedInException();
    }

    final matchesLocal = await _matchesLocalDataSource.getTodayMatchesForPlayer(
        playerId: playerId);

    final modelMatches =
        MatchesConverter.fromLocalEntitiesToModels(matchesLocal: matchesLocal);

    return modelMatches;
  }

  @override
  Future<List<MatchModel>> getMyPastMatches() async {
    final playerId = _authStatusDataSource.playerId;
    if (playerId == null) {
      // TODO responsible controller here should have access to logoutusecase, and use it to logout
      throw const AuthNotLoggedInException();
    }

    final matchesLocal = await _matchesLocalDataSource.getPastMatchesForPlayer(
        playerId: playerId);

    final modelMatches =
        MatchesConverter.fromLocalEntitiesToModels(matchesLocal: matchesLocal);

    return modelMatches;
  }

  @override
  Future<List<MatchModel>> getMyUpcomingMatches() async {
    final playerId = _authStatusDataSource.playerId;
    if (playerId == null) {
      // TODO responsible controller here should have access to logoutusecase, and use it to logout
      throw const AuthNotLoggedInException();
    }

    final matchesLocal = await _matchesLocalDataSource
        .getUpcomingMatchesForPlayer(playerId: playerId);

    final modelMatches =
        MatchesConverter.fromLocalEntitiesToModels(matchesLocal: matchesLocal);

    return modelMatches;
  }

  @override
  Future<int> loadMatch({
    required int matchId,
  }) async {
    final matchRemote =
        await _matchesRemoteDataSource.getMatch(matchId: matchId);

    final matchLocal = MatchesConverter.fromRemoteEntityToLocalEntity(
      matchRemote: matchRemote,
    );

    final id = await _matchesLocalDataSource.saveMatch(match: matchLocal);

    return id;
  }

  @override
  Future<MatchModel> getMatch({required int matchId}) async {
    final matchLocal = await _matchesLocalDataSource.getMatch(matchId: matchId);

    final modelMatch =
        MatchesConverter.fromLocalEntityToModel(matchLocal: matchLocal);

    return modelMatch;
  }

  @override
  Future<int> createMatch({
    required MatchCreateDataValue matchData,
  }) async {
    final id = await _matchesRemoteDataSource.createMatch(matchData: matchData);

    return id;
  }
}
