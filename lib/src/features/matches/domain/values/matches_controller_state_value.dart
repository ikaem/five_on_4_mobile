import 'package:equatable/equatable.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/models/match/match_model.dart';

class MatchesControllerStateValue extends Equatable {
  const MatchesControllerStateValue({
    required this.isRemoteFetchDone,
    required this.matches,
  });

  final bool isRemoteFetchDone;
  final List<MatchModel> matches;

  @override
  List<Object> get props => [isRemoteFetchDone, matches];
}
