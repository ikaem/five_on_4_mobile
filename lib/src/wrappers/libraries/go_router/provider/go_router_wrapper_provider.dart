import 'package:five_on_4_mobile/src/features/auth/presentation/controllers/auth_status/provider/auth_status_controller.dart';
import 'package:five_on_4_mobile/src/wrappers/libraries/go_router/go_router_wrapper.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'go_router_wrapper_provider.g.dart';

@riverpod
GoRouterWrapper goRouterWrapper(GoRouterWrapperRef ref) {
  // final authDataStatus = ref.watch(authStatusControllerProvider);
  // return GoRouterWrapper(authDataStatus: authDataStatus);
  return GoRouterWrapper(ref: ref);
}
