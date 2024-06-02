import 'package:five_on_4_mobile/src/features/auth/domain/models/auth_data/auth_data_model.dart';
import 'package:five_on_4_mobile/src/features/auth/domain/repositories/auth/auth_repository.dart';

class GetAuthDataStatusUseCase {
  GetAuthDataStatusUseCase({
    required AuthRepository authRepository,
  }) : _authRepository = authRepository;

  final AuthRepository _authRepository;

  Future<AuthDataModel?> call() async {
    return null;

    // return _authRepository.authDataStatus;
  }
}
