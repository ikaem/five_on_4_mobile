import 'package:five_on_4_mobile/src/features/core/utils/constants/database_name_constants.dart';
import 'package:five_on_4_mobile/src/wrappers/libraries/isar/isar_wrapper.dart';
import 'package:five_on_4_mobile/src/wrappers/libraries/path_provider/provider/path_provider_wrapper_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part "isar_wrapper_provider.g.dart";

// TODO not sure about this
@Riverpod(keepAlive: true)
IsarWrapper isarWrapper(
  IsarWrapperRef ref,
) {
  final pathProviderWrapper = ref.read(pathProviderWrapperProvider);

  return IsarWrapper(
    dbDirectory: pathProviderWrapper.getAppDocumentsDirectory(),
    databaseName: DatabaseNameConstants.DB_NAME,
  );
}
