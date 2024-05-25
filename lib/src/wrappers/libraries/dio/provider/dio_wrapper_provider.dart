import 'package:five_on_4_mobile/src/wrappers/libraries/dio/dio_interceptor.dart';
import 'package:five_on_4_mobile/src/wrappers/libraries/dio/dio_wrapper.dart';
import 'package:five_on_4_mobile/src/wrappers/libraries/flutter_secure_storage/provider/flutter_secure_storage_wrapper_provider.dart';
import 'package:five_on_4_mobile/src/wrappers/local/cookies_handler/cookies_handler_wrapper.dart';
import 'package:five_on_4_mobile/src/wrappers/local/provider/env_vars_wrapper_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dio_wrapper_provider.g.dart';

@riverpod
DioWrapper dioWrapper(
  DioWrapperRef ref,
) {
  // TODO no need to expose via provider
  const cookiesHandlerWrapper = CookiesHandlerWrapper();
  final envWrapper = ref.read(envVarsWrapperProvider);
  final flutterSecureStorageWrapper =
      ref.read(flutterSecureStorageWrapperProvider);

  final interceptor = DioInterceptor(
    cookiesHandlerWrapper: cookiesHandlerWrapper,
    envVarsWrapper: envWrapper,
    flutterSecureStorageWrapper: flutterSecureStorageWrapper,
  );

  final dioWrapper = DioWrapper(
    interceptor: interceptor,
  );

  return dioWrapper;
}
