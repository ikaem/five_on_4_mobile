import 'package:five_on_4_mobile/src/features/auth/presentation/controllers/authenticate_with_google/authenticate_with_google_controller.dart';
import 'package:five_on_4_mobile/src/features/auth/presentation/widgets/login/login_with_email_and_password_container.dart';
import 'package:five_on_4_mobile/src/features/auth/presentation/widgets/login/login_with_google_container.dart';
import 'package:five_on_4_mobile/src/features/auth/utils/constants/auth_screens_key_constants.dart';
import 'package:five_on_4_mobile/src/features/core/utils/constants/local_assets_path_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';

// TODO this also needs to be tested

class LoginScreenView extends ConsumerStatefulWidget {
  const LoginScreenView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _LoginScreenViewState();
}

class _LoginScreenViewState extends ConsumerState<LoginScreenView> {
  // late final authenticateWithGoogleController =
  //     ref.read(authenticateWithGoogleControllerProvider);

  @override
  Widget build(BuildContext context) {
    ref.listen(authenticateWithGoogleControllerProvider, (previous, next) {
      // TODO extract this to a method
      next.maybeWhen(
        orElse: () {},
        error: (e, s) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("There was an error authenticating with Google"),
            ),
          );
        },
        data: (state) {
          if (state == false) {
            return;
          }

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Authenticated successfully with Google"),
            ),
          );

          // TODO navigate to home screen
        },
      );
    });

    return Scaffold(
      body: Column(
        children: [
          Container(
            child: Image.asset(LocalAssetsPathConstants.LOGO_LARGE.value),
          ),
          const LoginWithEmailAndPasswordContainer(),
          // Container(
          //   child: const Column(
          //     children: [
          //       TextField(
          //         decoration: InputDecoration(
          //           border: OutlineInputBorder(),
          //           labelText: "Nickname",
          //         ),
          //       ),
          //       SizedBox(
          //         height: 10,
          //       ),
          //       TextField(
          //         obscureText: true,
          //         decoration: InputDecoration(
          //           border: OutlineInputBorder(),
          //           labelText: "Password",
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          // ElevatedButton(
          //   child: const Text("Login"),
          //   onPressed: () {},
          // ),
          const Divider(),
          LoginWithGoogleContainer(
            onAuthenticate: ref
                .read(authenticateWithGoogleControllerProvider.notifier)
                .onAuthenticate,
          ),
          // ElevatedButton(
          //   child: const Text("Login with Google"),
          //   onPressed: () async {
          //     // const serverId = String.fromEnvironment('GOOGLE_AUTH_SERVER_ID');
          //     // final GoogleSignIn googleSignIn = GoogleSignIn(
          //     //   serverClientId: serverId,
          //     //   // TODO no need for client id to get id token it seems
          //     //   // // TODO for ios this is maybe not needed
          //     //   // clientId:
          //     //   //     "164480400700-glgi0u7co675c5ubj8qdcbb834rqjqvd.apps.googleusercontent.com",
          //     //   scopes: <String>[
          //     //     // 'email',
          //     //     // "profile",
          //     //     // "openid",
          //     //   ],
          //     // );

          //     // try {
          //     //   // Get the user after successful sign in
          //     //   var account = await googleSignIn.signIn();

          //     //   if (account == null) {
          //     //     throw Exception('Google Sign In failed');
          //     //   }

          //     //   final auth = await account.authentication;

          //     //   final idToken = auth.idToken;

          //     //   print(auth.idToken);
          //     //   log(auth.idToken!);
          //     // } catch (e) {
          //     //   print(e);
          //     // }

          //     // // Get the user after successful sign in
          //   },
          // ),
          const SizedBox(
            height: 10,
          ),
          TextButton(
            onPressed: () {},
            child: const Text("Create account"),
          ),
          const Divider(),
          ElevatedButton(
            onPressed: () async {
              final googleSignIn = GoogleSignIn();
              await googleSignIn.signOut();
            },
            child: const Text("Temp google signout"),
          ),
        ],
      ),
    );
  }
}
