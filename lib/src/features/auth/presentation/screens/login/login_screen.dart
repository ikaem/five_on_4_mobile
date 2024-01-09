import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO create SafeAreaScaffold and user all over the app
    return SafeArea(
      child: Scaffold(
        body: ElevatedButton(
          child: const Text("Login"),
          onPressed: () {},
        ),
      ),
    );
  }
}
