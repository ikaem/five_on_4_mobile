import 'package:five_on_4_mobile/src/features/matches/data/data_sources/matches_local/matches_local_data_source.dart';
import 'package:five_on_4_mobile/src/features/matches/data/data_sources/matches_local/matches_local_data_source_impl.dart';
import 'package:five_on_4_mobile/src/wrappers/libraries/isar/provider/isar_wrapper_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part "matches_local_data_source_provider.g.dart";

@riverpod
MatchesLocalDataSource matchesLocalDataSource(MatchesLocalDataSourceRef ref) {
  final isarWrapper = ref.read(isarWrapperProvider);

  final dataSource = MatchesLocalDataSourceImpl(
    isarWrapper: isarWrapper,
  );

  return dataSource;
}
