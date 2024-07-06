import 'package:flutter/material.dart';

enum AuthScreensKeyConstants {
  LOGIN_SCREEN._(Key('login_screen')),
  REGISTER_SCREEN._(Key('register_screen'));

  const AuthScreensKeyConstants._(this.value);
  final Key value;
}
