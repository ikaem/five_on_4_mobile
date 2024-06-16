import 'package:flutter/material.dart';

// TODO this will required bunch of text edit controllers later

class LoginWithEmailAndPasswordContainer extends StatefulWidget {
  const LoginWithEmailAndPasswordContainer({super.key});

  @override
  State<LoginWithEmailAndPasswordContainer> createState() =>
      _LoginWithEmailAndPasswordContainerState();
}

class _LoginWithEmailAndPasswordContainerState
    extends State<LoginWithEmailAndPasswordContainer> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
        )
      ],
    );
  }
}
