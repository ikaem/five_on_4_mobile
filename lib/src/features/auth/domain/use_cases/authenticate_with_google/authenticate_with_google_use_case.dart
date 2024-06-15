import 'package:five_on_4_mobile/src/features/auth/domain/repositories/auth/auth_repository.dart';

class AuthenticateWithGoogleUseCase {
  AuthenticateWithGoogleUseCase({
    required AuthRepository authRepository,
  }) : _authRepository = authRepository;

  final AuthRepository _authRepository;

  Future<void> call() {
    return _authRepository.authenticateWithGoogle();
  }
}
