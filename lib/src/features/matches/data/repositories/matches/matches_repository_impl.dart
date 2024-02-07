import 'package:five_on_4_mobile/src/features/auth/data/data_sources/auth_status/auth_status_data_source.dart';
import 'package:five_on_4_mobile/src/features/auth/domain/exceptions/auth_exceptions.dart';
import 'package:five_on_4_mobile/src/features/matches/data/data_sources/matches_local/matches_local_data_source.dart';
import 'package:five_on_4_mobile/src/features/matches/data/data_sources/matches_remote/matches_remote_data_source.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/models/match/match_model.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/repositories_interfaces.dart';
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
        await _matchesRemoteDataSource.getMyFollowingMatches();

    final matchesLocal = MatchesConverter.fromRemoteEntitiesToLocalEntities(
      matchesRemote: matchesRemote,
    );

    await _matchesLocalDataSource.saveMatches(matches: matchesLocal);
  }

  @override
  Future<List<MatchModel>> getMyTodayMatches() async {
    final playerId = _authStatusDataSource.playerId;
    if (playerId == null) {
      // TODO log error
      // TODO also this should logout the user
      // TODO
      /* 
      - we could potentially throw specific exeption here 
      - the controller should pick it up
      - then if there is this error - controller should do what? somehow logout? call use case of logout?
       */
      // TODO make concrete exception here
      throw const AuthNotLoggedInException();
    }

    final matchesLocal = await _matchesLocalDataSource.getTodayMatchesForPlayer(
        playerId: playerId);

    final modelMatches =
        MatchesConverter.fromLocalEntitiesToModels(matchesLocal: matchesLocal);

    return modelMatches;
  }
}
