import 'package:five_on_4_mobile/src/features/auth/data/data_sources/auth_status/auth_status_data_source.dart';
import 'package:five_on_4_mobile/src/features/auth/domain/exceptions/auth_exceptions.dart';
import 'package:five_on_4_mobile/src/features/matches/data/data_sources/matches_local/matches_local_data_source.dart';
import 'package:five_on_4_mobile/src/features/matches/data/data_sources/matches_remote/matches_remote_data_source.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/models/match/match_model.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/repositories/matches/matches_repository.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/values/match_create_data_value.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/values/match_local_entity_value.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/values/player_match_models_overview_value.dart';
import 'package:five_on_4_mobile/src/features/matches/utils/converters/matches_converter.dart';

class MatchesRepositoryImpl implements MatchesRepository {
  const MatchesRepositoryImpl({
    required MatchesLocalDataSource matchesLocalDataSource,
    required MatchesRemoteDataSource matchesRemoteDataSource,
    // required AuthStatusDataSource authStatusDataSource,
  })  : _matchesLocalDataSource = matchesLocalDataSource,
        _matchesRemoteDataSource = matchesRemoteDataSource;
  // _authStatusDataSource = authStatusDataSource;

  final MatchesLocalDataSource _matchesLocalDataSource;
  final MatchesRemoteDataSource _matchesRemoteDataSource;
  // final AuthStatusDataSource _authStatusDataSource;

  @override
  Future<int> createMatch({
    required MatchCreateDataValue matchData,
  }) async {
    // throw UnimplementedError();
    final id = await _matchesRemoteDataSource.createMatch(matchData: matchData);

    return id;

    //   return id;
  }

  @override
  Future<void> loadMatch({
    required int matchId,
  }) async {
    final remoteEntity =
        await _matchesRemoteDataSource.getMatch(matchId: matchId);

    final localEntityValue = MatchLocalEntityValue(
      id: remoteEntity.id,
      dateAndTime: remoteEntity.dateAndTime,
      title: remoteEntity.title,
      location: remoteEntity.location,
      description: remoteEntity.description,
    );

    await _matchesLocalDataSource.storeMatch(matchValue: localEntityValue);

    // final matchRemote =
    //     await _matchesRemoteDataSource.getMatch(matchId: matchId);

    // final matchLocal = MatchesConverter.fromRemoteEntityToLocalEntity(
    //   matchRemote: matchRemote,
    // );

    // final id = await _matchesLocalDataSource.saveMatch(match: matchLocal);

    // return id;
  }

  @override
  Future<void> loadPlayerMatchesOverview({required int playerId}) async {
    final remoteEntities = await _matchesRemoteDataSource
        .getPlayerMatchesOverview(playerId: playerId);

    final localEntityValues =
        MatchesConverter.fromRemoteEntitiesToLocalEntityValues(
            matchesRemote: remoteEntities);

    await _matchesLocalDataSource.storeMatches(matchValues: localEntityValues);
  }

  @override
  Future<PlayerMatchModelsOverviewValue> getPlayerMatchesOverview({
    required int playerId,
  }) async {
    final localEntitiesValue = await _matchesLocalDataSource
        .getPlayerMatchesOverview(playerId: playerId);

    // TODO create converter for this
    final modelValue = PlayerMatchModelsOverviewValue(
      todayMatches: localEntitiesValue.todayMatches
          .map(
            (e) => MatchModel(
              id: e.id,
              dateAndTime: DateTime.fromMillisecondsSinceEpoch(e.dateAndTime),
              location: e.location,
              description: e.description,
              title: e.title,
            ),
          )
          .toList(),
      upcomingMatches: localEntitiesValue.upcomingMatches
          .map(
            (e) => MatchModel(
              id: e.id,
              dateAndTime: DateTime.fromMillisecondsSinceEpoch(e.dateAndTime),
              location: e.location,
              description: e.description,
              title: e.title,
            ),
          )
          .toList(),
      pastMatches: localEntitiesValue.pastMatches
          .map(
            (e) => MatchModel(
              id: e.id,
              dateAndTime: DateTime.fromMillisecondsSinceEpoch(e.dateAndTime),
              location: e.location,
              description: e.description,
              title: e.title,
            ),
          )
          .toList(),
    );

    return modelValue;
  }

  // TODO probably deprecated
  @override
  Future<void> loadMyMatches() async {
    // TODO use new function here
    throw UnimplementedError();
    // final matchesRemote =
    //     await _matchesRemoteDataSource.getPlayerInitialMatches();

    // final matchesLocal = MatchesConverter.fromRemoteEntitiesToLocalEntities(
    //   matchesRemote: matchesRemote,
    // );

    // await _matchesLocalDataSource.saveMatches(matches: matchesLocal);
  }

  @override
  Future<List<MatchModel>> getMyTodayMatches() async {
    throw UnimplementedError();
    // TODO useCases could also possibly get playerId and then ping some generic fucntions inside the repository
    // final playerId = _authStatusDataSource.playerId;
    // if (playerId == null) {
    //   // TODO responsible controller here should have access to logoutusecase, and use it to logout
    //   throw const AuthNotLoggedInException();
    // }

    // final matchesLocal = await _matchesLocalDataSource.getTodayMatchesForPlayer(
    //     playerId: playerId);

    // final modelMatches =
    //     MatchesConverter.fromLocalEntitiesToModels(matchesLocal: matchesLocal);

    // return modelMatches;
  }

  @override
  Future<List<MatchModel>> getMyPastMatches() async {
    throw UnimplementedError();
    // final playerId = _authStatusDataSource.playerId;
    // if (playerId == null) {
    //   // TODO responsible controller here should have access to logoutusecase, and use it to logout
    //   throw const AuthNotLoggedInException();
    // }

    // final matchesLocal = await _matchesLocalDataSource.getPastMatchesForPlayer(
    //     playerId: playerId);

    // final modelMatches =
    //     MatchesConverter.fromLocalEntitiesToModels(matchesLocal: matchesLocal);

    // return modelMatches;
  }

  @override
  Future<List<MatchModel>> getMyUpcomingMatches() async {
    throw UnimplementedError();
    // final playerId = _authStatusDataSource.playerId;
    // if (playerId == null) {
    //   // TODO responsible controller here should have access to logoutusecase, and use it to logout
    //   throw const AuthNotLoggedInException();
    // }

    // final matchesLocal = await _matchesLocalDataSource
    //     .getUpcomingMatchesForPlayer(playerId: playerId);

    // final modelMatches =
    //     MatchesConverter.fromLocalEntitiesToModels(matchesLocal: matchesLocal);

    // return modelMatches;
  }

  @override
  Future<MatchModel> getMatch({required int matchId}) async {
    final localEntityValue =
        await _matchesLocalDataSource.getMatch(matchId: matchId);

    // TODO maybe converter exists already
    final matchModel = MatchModel(
      id: localEntityValue.id,
      dateAndTime:
          DateTime.fromMillisecondsSinceEpoch(localEntityValue.dateAndTime),
      location: localEntityValue.location,
      description: localEntityValue.description,
      title: localEntityValue.title,
    );

    return matchModel;

    // throw UnimplementedError();
    // final matchLocal = await _matchesLocalDataSource.getMatch(matchId: matchId);

    // final modelMatch =
    //     MatchesConverter.fromLocalEntityToModel(matchLocal: matchLocal);

    // return modelMatch;
  }
}
