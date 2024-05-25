import 'package:equatable/equatable.dart';

class AuthRemoteEntity extends Equatable {
  final int id;
  final String email;
  final String nickname;
  final String name;
  final String avatarUrl;

  const AuthRemoteEntity({
    required this.id,
    required this.email,
    required this.nickname,
    required this.name,
    required this.avatarUrl,
  });

  factory AuthRemoteEntity.fromJson(Map<String, dynamic> json) {
    return AuthRemoteEntity(
      id: json['id'],
      email: json['email'],
      nickname: json['nickname'],
      name: json['name'],
      avatarUrl: json['avatarUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'nickname': nickname,
      'name': name,
      'avatarUrl': avatarUrl,
    };
  }

  @override
  List<Object> get props => [id, email, nickname, name, avatarUrl];
}


/* 


export type AuthModel = {
  id: number;
  email: string;
  nickname: string;
  name: string;
  avatarUrl: string;
};


 */