import 'package:equatable/equatable.dart';
import 'package:five_on_4_mobile/src/features/auth/domain/models/authenticated_player/authenticated_player_model.dart';

class GetAuthenticatedPlayerControllerState extends Equatable {
  const GetAuthenticatedPlayerControllerState({
    required this.authenticatedPlayer,
  });

  final AuthenticatedPlayerModel authenticatedPlayer;

  @override
  List<Object?> get props => [authenticatedPlayer];
}
