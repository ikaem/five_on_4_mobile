import 'package:five_on_4_mobile/src/features/auth/domain/repositories/auth/provider/auth_repository_provider.dart';
import 'package:five_on_4_mobile/src/features/auth/domain/use_cases/get_auth_data_status_stream/get_auth_data_status_stream_use_case.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part "get_auth_data_status_stream_use_case_provider.g.dart";

@riverpod
GetAuthDataStatusStreamUseCase getAuthDataStatusStreamUseCase(
  GetAuthDataStatusStreamUseCaseRef ref,
) {
  final authRepository = ref.read(authRepositoryProvider);

  return GetAuthDataStatusStreamUseCase(
    authRepository: authRepository,
  );
}

// TODO not needed