import 'package:five_on_4_mobile/src/features/auth/domain/repositories/auth/auth_repository.dart';

class LoadAuthenticatedPlayerFromRemoteUseCase {
  const LoadAuthenticatedPlayerFromRemoteUseCase({
    required AuthRepository authRepository,
  }) : _authRepository = authRepository;

  final AuthRepository _authRepository;

  Future<void> call() async {
    return await _authRepository.loadAuthenticatedPlayerFromRemote();
  }
}
