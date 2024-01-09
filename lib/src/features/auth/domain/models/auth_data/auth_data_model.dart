import 'package:flutter/material.dart';

@immutable
class AuthDataModel {
  const AuthDataModel({
    required this.playerId,
    required this.fullName,
    required this.nickName,
    required this.teamId,
    required this.teamName,
  });

  final int playerId;
  final String fullName;
  final String nickName;
  final int teamId;
  final String teamName;
}
