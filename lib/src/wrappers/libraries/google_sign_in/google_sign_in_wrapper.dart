import 'dart:developer';

import 'package:five_on_4_mobile/src/features/auth/domain/exceptions/auth_exceptions.dart';
import 'package:five_on_4_mobile/src/wrappers/local/env_vars_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

// TODO test this
class GoogleSignInWrapper {
  // TODO how to test this?
  // TODO we could in theory pass GoogleSignIn as a param - lets try it
  @visibleForTesting
  GoogleSignInWrapper({
    required GoogleSignIn googleSignIn,
  }) : _googleSignIn = googleSignIn;

// TODO not sure about this - this is alternative
  // GoogleSignInWrapper({
  //   required String serverClientId,
  // }) : _googleSignIn = GoogleSignIn(
  //         serverClientId: serverClientId,
  //         scopes: [
  //           // TODO no scopes for now
  //         ],
  //       );

  factory GoogleSignInWrapper.createDefault({
    required EnvVarsWrapper envVarsWrapper,
  }) {
    return GoogleSignInWrapper(
      googleSignIn: GoogleSignIn(
        serverClientId: envVarsWrapper.googleAuthServerId,
        scopes: [
          // TODO no scopes for now
        ],
      ),
    );
  }

  final GoogleSignIn _googleSignIn;

/* TODO deprecate this */
  Future<String> signInAndGetIdToken() async {
    final account = await _googleSignIn.signIn();
    if (account == null) {
      // TODO make better exception
      // TODO create custom exception in auth exceptions
      // throw Exception('Unable to retrieve account from Google Sign In.');
      throw const AuthCannotRetrieveGoogleAccountException();
    }
    final auth = await account.authentication;

    final idToken = auth.idToken;
    if (idToken == null) {
      // TODO make better expection
      // throw Exception('Google SignIn idToken is null');
      throw const AuthGoogleSignInIdTokenNullException();
    }

    log("GoogleSignInWrapper: idToken: $idToken");

    return idToken;
  }

// TODO dont forget to call this as well on regular logout
// TODO this is not tested yet
  Future<void> signOut() async {
    await _googleSignIn.signOut();
  }
}
