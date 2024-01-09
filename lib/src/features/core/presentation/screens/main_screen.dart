import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO create SafeAreaScaffold and user all over the app
    return const SafeArea(
      child: Scaffold(
        body: Text(
          "Main Screen",
        ),
      ),
    );
  }
}
