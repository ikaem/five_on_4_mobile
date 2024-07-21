import 'package:auto_route/auto_route.dart';
import 'package:five_on_4_mobile/src/features/auth/presentation/screens/login/login_screen_view.dart';
import 'package:five_on_4_mobile/src/features/auth/utils/constants/auth_screens_key_constants.dart';
import 'package:flutter/material.dart';

typedef OnLogin = void Function(bool isLoggedIn);

@RoutePage()
class LoginScreen extends StatelessWidget {
  const LoginScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      key: AuthScreensKeyConstants.LOGIN_SCREEN.value,
      child: const LoginScreenView(),
    );
  }
}
