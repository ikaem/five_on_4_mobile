import 'package:equatable/equatable.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/models/match/match_model.dart';

class MatchesStateValue extends Equatable {
  const MatchesStateValue({
    required this.isFetchingRemoteData,
    required this.matches,
  });

  final bool isFetchingRemoteData;
  final List<MatchModel> matches;

  @override
  List<Object> get props => [isFetchingRemoteData, matches];
}
