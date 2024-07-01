import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:five_on_4_mobile/src/features/auth/presentation/screens/login/login_screen_view.dart';
import 'package:five_on_4_mobile/src/features/auth/utils/constants/auth_screens_key_constants.dart';
import 'package:five_on_4_mobile/src/features/core/utils/constants/local_assets_path_constants.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

@RoutePage()
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO create SafeAreaScaffold and user all over the app
    return SafeArea(
      key: AuthScreensKeyConstants.LOGIN_SCREEN.value,
      child: const LoginScreenView(),
    );
  }
}
