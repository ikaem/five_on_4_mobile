import 'package:five_on_4_mobile/src/features/matches/data/data_sources/matches_local/matches_local_data_source.dart';
import 'package:five_on_4_mobile/src/features/matches/data/data_sources/matches_remote/matches_remote_data_source.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/repositories_interfaces.dart';

class MatchesRepositoryImpl implements MatchesRepository {
  const MatchesRepositoryImpl({
    required MatchesLocalDataSource matchesLocalDataSource,
    required MatchesRemoteDataSource matchesRemoteDataSource,
  })  : _matchesLocalDataSource = matchesLocalDataSource,
        _matchesRemoteDataSource = matchesRemoteDataSource;

  final MatchesLocalDataSource _matchesLocalDataSource;
  final MatchesRemoteDataSource _matchesRemoteDataSource;

  @override
  Future<void> loadMyMatches() async {
    final matchesRemote =
        await _matchesRemoteDataSource.getMyFollowingMatches();
  }
}
