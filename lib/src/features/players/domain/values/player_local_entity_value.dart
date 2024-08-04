import 'package:equatable/equatable.dart';

class PlayerLocalEntityValue extends Equatable {
  const PlayerLocalEntityValue({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.nickname,
    required this.avatarUrl,
  });

  final int id;
  final String firstName;
  final String lastName;
  final String nickname;
  final String avatarUrl;

  @override
  List<Object?> get props => [id, firstName, lastName, nickname];
}
