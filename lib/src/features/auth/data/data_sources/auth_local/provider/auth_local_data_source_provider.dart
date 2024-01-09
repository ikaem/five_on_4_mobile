import 'package:five_on_4_mobile/src/features/auth/data/data_sources/auth_local/auth_local_data_source.dart';
import 'package:five_on_4_mobile/src/features/auth/data/data_sources/auth_local/auth_local_data_source_impl.dart';
import 'package:five_on_4_mobile/src/wrappers/libraries/flutter_secure_storage/provider/flutter_secure_storage_wrapper_provider.dart';
import 'package:five_on_4_mobile/src/wrappers/libraries/isar/provider/isar_wrapper_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part "auth_local_data_source_provider.g.dart";

@riverpod
AuthLocalDataSource authLocalDataSource(
  AuthLocalDataSourceRef ref,
) {
  final secureStorageWrapper = ref.read(flutterSecureStorageWrapperProvider);
  final isarWrapper = ref.read(isarWrapperProvider);

  return AuthLocalDataSourceImpl(
    secureStorageWrapper: secureStorageWrapper,
    isarWrapper: isarWrapper,
  );
}
