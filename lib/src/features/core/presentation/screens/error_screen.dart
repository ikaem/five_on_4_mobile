import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

@RoutePage()
class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});

  final message = "There seems to have been an error. Please try again later.";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Column(
            children: [
              const Text("Ooops!"),
              const Divider(),
              Text(message),
              const Divider(),
              TextButton(
                onPressed: () => context.pop(),
                child: const Text("Go back"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
