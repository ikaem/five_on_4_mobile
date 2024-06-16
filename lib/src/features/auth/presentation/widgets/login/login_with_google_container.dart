import 'package:flutter/material.dart';

class LoginWithGoogleContainer extends StatelessWidget {
  const LoginWithGoogleContainer({
    super.key,
    required this.onAuthenticate,
  });

  final Future<void> Function() onAuthenticate;

// TODO this widget needs to be tested that it has correct stuff

// TODO will also need to test login screen
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onAuthenticate,
      child: const Text("Login with Google"),
      // onPressed: () async {
      // const serverId = String.fromEnvironment('GOOGLE_AUTH_SERVER_ID');
      // final GoogleSignIn googleSignIn = GoogleSignIn(
      //   serverClientId: serverId,
      //   // TODO no need for client id to get id token it seems
      //   // // TODO for ios this is maybe not needed
      //   // clientId:
      //   //     "164480400700-glgi0u7co675c5ubj8qdcbb834rqjqvd.apps.googleusercontent.com",
      //   scopes: <String>[
      //     // 'email',
      //     // "profile",
      //     // "openid",
      //   ],
      // );

      // try {
      //   // Get the user after successful sign in
      //   var account = await googleSignIn.signIn();

      //   if (account == null) {
      //     throw Exception('Google Sign In failed');
      //   }

      //   final auth = await account.authentication;

      //   final idToken = auth.idToken;

      //   print(auth.idToken);
      //   log(auth.idToken!);
      // } catch (e) {
      //   print(e);
      // }

      // // Get the user after successful sign in
      // },
    );
  }
}
