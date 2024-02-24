import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class AuthDataModel extends Equatable {
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

  @override
  List<Object?> get props => [
        playerId,
        fullName,
        nickName,
        teamId,
        teamName,
      ];
}
