import 'package:five_on_4_mobile/src/features/auth/data/data_sources/auth_status/auth_status_data_source.dart';
import 'package:five_on_4_mobile/src/features/matches/data/data_sources/matches_local/matches_local_data_source.dart';
import 'package:five_on_4_mobile/src/features/matches/data/data_sources/matches_remote/matches_remote_data_source.dart';
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
}
