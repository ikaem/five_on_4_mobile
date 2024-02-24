import 'package:five_on_4_mobile/src/features/auth/data/repositories/auth/provider/auth_repository_provider.dart';
import 'package:five_on_4_mobile/src/features/auth/domain/use_cases/get_auth_data_status/get_auth_data_status_use_case.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part "get_auth_data_status_use_case_provider.g.dart";

@riverpod
GetAuthDataStatusUseCase getAuthDataStatusUseCase(
    GetAuthDataStatusUseCaseRef ref) {
  final authRepository = ref.read(authRepositoryProvider);

  final useCase = GetAuthDataStatusUseCase(
    authRepository: authRepository,
  );
  return useCase;
}
