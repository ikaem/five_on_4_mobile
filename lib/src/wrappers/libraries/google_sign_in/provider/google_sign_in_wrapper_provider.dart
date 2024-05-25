import 'package:five_on_4_mobile/src/wrappers/libraries/google_sign_in/google_sign_in_wrapper.dart';
import 'package:five_on_4_mobile/src/wrappers/local/provider/env_vars_wrapper_provider.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part "google_sign_in_wrapper_provider.g.dart";

// TODO not sure if this should be lazy or not - lets see
@riverpod
GoogleSignInWrapper googleSignInWrapper(GoogleSignInWrapperRef ref) {
  // TODO not sure I like this
  final envVarWrapper = ref.read(envVarsWrapperProvider);
  final googleSignIn = GoogleSignIn(
    serverClientId: envVarWrapper.googleAuthServerId,
    scopes: [
      // TODO no scopes for now
    ],
  );

  return GoogleSignInWrapper(
    googleSignIn: googleSignIn,
  );
}
