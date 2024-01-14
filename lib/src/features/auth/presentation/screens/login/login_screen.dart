import 'package:five_on_4_mobile/src/features/auth/utils/constants/auth_screens_key_constants.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO create SafeAreaScaffold and user all over the app
    return SafeArea(
      key: AuthScreensKeyConstants.LOGIN_SCREEN.value,
      child: Scaffold(
        body: ElevatedButton(
          child: const Text("Login"),
          onPressed: () {},
        ),
      ),
    );
  }
}
