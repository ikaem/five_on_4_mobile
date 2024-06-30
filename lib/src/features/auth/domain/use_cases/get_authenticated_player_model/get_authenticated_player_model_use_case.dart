import 'package:five_on_4_mobile/src/features/auth/domain/models/authenticated_player/authenticated_player_model.dart';
import 'package:five_on_4_mobile/src/features/auth/domain/repositories/auth/auth_repository.dart';

class GetAuthenticatedPlayerModelUseCase {
  const GetAuthenticatedPlayerModelUseCase({
    required AuthRepository authRepository,
  }) : _authRepository = authRepository;

  final AuthRepository _authRepository;

  Future<AuthenticatedPlayerModel?> call() async {
    final authPlayerModel = _authRepository.getAuthenticatedPlayerModel();
    return authPlayerModel;
  }
}


/* 





TestFailure (Matching call #2 not found. All calls: _MockListener<AsyncValue<PlayerMatchesOverviewControllerState>>.call(null, AsyncLoading<PlayerMatchesOverviewControllerState>()), _MockListener<AsyncValue<PlayerMatchesOverviewControllerState>>.call(
    AsyncLoading<PlayerMatchesOverviewControllerState>(),
    AsyncError<PlayerMatchesOverviewControllerState>(error: AuthException -> No logged in player, stackTrace: #0   









 */