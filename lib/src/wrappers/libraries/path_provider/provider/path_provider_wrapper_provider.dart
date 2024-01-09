import 'package:five_on_4_mobile/src/wrappers/libraries/path_provider/path_provider_wrapper.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part "path_provider_wrapper_provider.g.dart";

@riverpod
PathProviderWrapper pathProviderWrapper(
  PathProviderWrapperRef ref,
) {
  return const PathProviderWrapper();
}
