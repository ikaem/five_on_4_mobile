import 'package:five_on_4_mobile/src/wrappers/local/env_vars_wrapper.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part "env_vars_wrapper_provider.g.dart";

@riverpod
EnvVarsWrapper envVarsWrapper(EnvVarsWrapperRef ref) {
  return EnvVarsWrapper();
}
