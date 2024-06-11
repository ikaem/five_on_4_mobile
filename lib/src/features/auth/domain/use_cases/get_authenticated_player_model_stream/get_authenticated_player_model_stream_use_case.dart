import 'package:five_on_4_mobile/src/features/auth/domain/models/authenticated_player/authenticated_player_model.dart';
import 'package:five_on_4_mobile/src/features/auth/domain/repositories/auth/auth_repository.dart';

class GetAuthenticatedPlayerModelStreamUseCase {
  GetAuthenticatedPlayerModelStreamUseCase({
    required AuthRepository authRepository,
  }) : _authRepository = authRepository;

  final AuthRepository _authRepository;

  Stream<AuthenticatedPlayerModel?> call() {
    return _authRepository.getAuthenticatedPlayerModelStream();
  }
}
