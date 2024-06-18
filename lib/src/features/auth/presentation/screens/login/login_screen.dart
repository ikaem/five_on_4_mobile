import 'dart:developer';

import 'package:five_on_4_mobile/src/features/auth/presentation/screens/login/login_screen_view.dart';
import 'package:five_on_4_mobile/src/features/auth/utils/constants/auth_screens_key_constants.dart';
import 'package:five_on_4_mobile/src/features/core/utils/constants/local_assets_path_constants.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO create SafeAreaScaffold and user all over the app
    return SafeArea(
      key: AuthScreensKeyConstants.LOGIN_SCREEN.value,
      child: const LoginScreenView(),
      // child: Scaffold(
      //   body: Column(
      //     children: [
      //       Container(
      //         child: Image.asset(LocalAssetsPathConstants.LOGO_LARGE.value),
      //       ),
      //       Container(
      //         child: const Column(
      //           children: [
      //             TextField(
      //               decoration: InputDecoration(
      //                 border: OutlineInputBorder(),
      //                 labelText: "Nickname",
      //               ),
      //             ),
      //             SizedBox(
      //               height: 10,
      //             ),
      //             TextField(
      //               obscureText: true,
      //               decoration: InputDecoration(
      //                 border: OutlineInputBorder(),
      //                 labelText: "Password",
      //               ),
      //             ),
      //           ],
      //         ),
      //       ),
      //       ElevatedButton(
      //         child: const Text("Login"),
      //         onPressed: () {},
      //       ),
      //       const Divider(),
      //       ElevatedButton(
      //         child: const Text("Login with Google"),
      //         onPressed: () async {
      //           const serverId =
      //               String.fromEnvironment('GOOGLE_AUTH_SERVER_ID');
      //           final GoogleSignIn googleSignIn = GoogleSignIn(
      //             serverClientId: serverId,
      //             // TODO no need for client id to get id token it seems
      //             // // TODO for ios this is maybe not needed
      //             // clientId:
      //             //     "164480400700-glgi0u7co675c5ubj8qdcbb834rqjqvd.apps.googleusercontent.com",
      //             scopes: <String>[
      //               // 'email',
      //               // "profile",
      //               // "openid",
      //             ],
      //           );

      //           try {
      //             // Get the user after successful sign in
      //             var account = await googleSignIn.signIn();

      //             if (account == null) {
      //               throw Exception('Google Sign In failed');
      //             }

      //             final auth = await account.authentication;

      //             final idToken = auth.idToken;

      //             print(auth.idToken);
      //             log(auth.idToken!);
      //           } catch (e) {
      //             print(e);
      //           }

      //           // Get the user after successful sign in
      //         },
      //       ),
      //       const SizedBox(
      //         height: 10,
      //       ),
      //       TextButton(
      //         onPressed: () {},
      //         child: const Text("Create account"),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
