import 'package:equatable/equatable.dart';
import 'package:isar/isar.dart';

part "auth_local_entity.g.dart";

@Collection(inheritance: false)
class AuthLocalEntity extends Equatable {
  const AuthLocalEntity({
    required this.id,
    required this.email,
    required this.nickname,
    required this.name,
    required this.avatarUrl,
  });

  final Id id;

  final String email;
  final String nickname;
  final String name;
  final String avatarUrl;

  @ignore
  @override
  List<Object?> get props => [
        id,
        email,
        nickname,
        name,
        avatarUrl,
      ];
}
