import 'package:five_on_4_mobile/src/wrappers/libraries/dio/dio_interceptor.dart';
import 'package:five_on_4_mobile/src/wrappers/libraries/dio/dio_wrapper.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dio_wrapper_provider.g.dart';

@riverpod
DioWrapper dioWrapper(
  DioWrapperRef ref,
) {
  final interceptor = DioInterceptor();
  final dioWrapper = DioWrapper(
    interceptor: interceptor,
  );

  return dioWrapper;
}
