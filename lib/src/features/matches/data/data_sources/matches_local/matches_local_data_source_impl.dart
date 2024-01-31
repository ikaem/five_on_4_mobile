import 'package:five_on_4_mobile/src/features/matches/data/data_sources/matches_local/matches_local_data_source.dart';
import 'package:five_on_4_mobile/src/features/matches/data/entities/match_remote/match_local/match_local_entity.dart';
import 'package:five_on_4_mobile/src/wrappers/libraries/isar/isar_wrapper.dart';

class MatchesLocalDataSourceImpl implements MatchesLocalDataSource {
  const MatchesLocalDataSourceImpl({
    required IsarWrapper isarWrapper,
  }) : _isarWrapper = isarWrapper;

  final IsarWrapper _isarWrapper;

  // @override
  // Future<List<int>> saveMatches({
  //   required List<MatchLocalEntity> matches,
  // }) async {
  //   final ids = await _isarWrapper.putEntities<MatchLocalEntity>(
  //     entities: matches,
  //   );

  //   return ids;
  // }
}
