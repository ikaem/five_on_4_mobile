import 'package:five_on_4_mobile/src/features/auth/utils/constants/auth_screens_key_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// TODO this is very temp
// TODO this needs testing

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        key: AuthScreensKeyConstants.REGISTER_SCREEN.value,
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Register"),
          ),
          body: const Text(
            "Register Screen",
          ),
        )
        // child: const Text(
        //   "Register Screen",
        // ),
        );
  }
}
