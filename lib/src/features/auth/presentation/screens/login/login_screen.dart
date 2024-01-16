import 'package:five_on_4_mobile/src/features/auth/utils/constants/auth_screens_key_constants.dart';
import 'package:five_on_4_mobile/src/features/core/utils/constants/local_assets_path_constants.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO create SafeAreaScaffold and user all over the app
    return SafeArea(
      key: AuthScreensKeyConstants.LOGIN_SCREEN.value,
      child: Scaffold(
        body: Column(
          children: [
            Container(
              child: Image.asset(LocalAssetsPathConstants.LOGO_LARGE.value),
            ),
            Container(
              child: const Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Nickname",
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Password",
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              child: const Text("Login"),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
