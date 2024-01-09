import 'package:five_on_4_mobile/src/features/auth/data/data_sources/auth_status/auth_status_data_source.dart';
import 'package:five_on_4_mobile/src/features/auth/data/data_sources/auth_status/auth_status_data_source_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part "auth_status_data_source_provider.g.dart";

@Riverpod(keepAlive: true)
AuthStatusDataSource authStatusDataSource(
  AuthStatusDataSourceRef ref,
) {
  final authStatusDataSource = AuthStatusDataSourceImpl();
  ref.onDispose(() => authStatusDataSource.dispose());

  return authStatusDataSource;
}
