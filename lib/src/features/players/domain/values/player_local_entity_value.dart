import 'package:equatable/equatable.dart';

class PlayerLocalEntityValue extends Equatable {
  const PlayerLocalEntityValue({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.nickname,
  });

  final int id;
  final String firstName;
  final String lastName;
  final String nickname;

  @override
  List<Object?> get props => [id, firstName, lastName, nickname];
}
