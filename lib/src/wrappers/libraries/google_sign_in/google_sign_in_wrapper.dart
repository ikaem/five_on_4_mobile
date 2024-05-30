import 'package:google_sign_in/google_sign_in.dart';

// TODO test this
class GoogleSignInWrapper {
  // TODO how to test this?
  // TODO we could in theory pass GoogleSignIn as a param - lets try it
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

  final GoogleSignIn _googleSignIn;

  Future<String> signInAndGetIdToken() async {
    final account = await _googleSignIn.signIn();
    if (account == null) {
      // TODO create custom exception in auth exceptions
      throw Exception('Unable to retrieve account from Google Sign In.');
    }
    final auth = await account.authentication;

    final idToken = auth.idToken;
    if (idToken == null) {
      throw Exception('Google SignIn idToken is null');
    }

    return idToken;
  }

// TODO dont forget to call this as well on regular logout
  Future<void> signOut() async {
    await _googleSignIn.signOut();
  }
}
