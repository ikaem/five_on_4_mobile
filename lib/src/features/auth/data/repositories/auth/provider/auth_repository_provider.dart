import 'package:five_on_4_mobile/src/features/auth/data/data_sources/auth_local/provider/auth_local_data_source_provider.dart';
import 'package:five_on_4_mobile/src/features/auth/data/data_sources/auth_status/provider/auth_status_data_source_provider.dart';
import 'package:five_on_4_mobile/src/features/auth/data/repositories/auth/auth_repository_impl.dart';
import 'package:five_on_4_mobile/src/features/auth/domain/repository_interfaces/auth/auth_repository.dart';
import 'package:five_on_4_mobile/src/wrappers/libraries/flutter_secure_storage/provider/flutter_secure_storage_wrapper_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part "auth_repository_provider.g.dart";

@riverpod
AuthRepository authRepository(
  AuthRepositoryRef ref,
) {
  final authLocalDataSource = ref.read(authLocalDataSourceProvider);
  final authStatusDataSource = ref.read(authStatusDataSourceProvider);
  final flutterSecureStorageWrapper =
      ref.read(flutterSecureStorageWrapperProvider);

  return AuthRepositoryImpl(
    authLocalDataSource: authLocalDataSource,
    authStatusDataSource: authStatusDataSource,
    flutterSecureStorageWrapper: flutterSecureStorageWrapper,
  );
}
