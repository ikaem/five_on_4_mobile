import 'package:five_on_4_mobile/src/features/auth/data/data_sources/auth_status/provider/auth_status_data_source_provider.dart';
import 'package:five_on_4_mobile/src/features/matches/data/data_sources/matches_local/provider/matches_local_data_source_provider.dart';
import 'package:five_on_4_mobile/src/features/matches/data/data_sources/matches_remote/provider/matches_remote_data_source_provider.dart';
import 'package:five_on_4_mobile/src/features/matches/data/repositories/matches/matches_repository_impl.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/repository_interfaces/matches_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part "matches_repository_provider.g.dart";

@riverpod
MatchesRepository matchesRepository(
  MatchesRepositoryRef ref,
) {
  final localDataSource = ref.read(matchesLocalDataSourceProvider);
  final remoteDataSource = ref.read(matchesRemoteDataSourceProvider);
  final authStatusDataSource = ref.read(authStatusDataSourceProvider);

  final repository = MatchesRepositoryImpl(
    matchesLocalDataSource: localDataSource,
    matchesRemoteDataSource: remoteDataSource,
    authStatusDataSource: authStatusDataSource,
  );

  return repository;
}
