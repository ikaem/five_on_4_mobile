import 'package:equatable/equatable.dart';

class MatchCreateInputArgs extends Equatable {
  const MatchCreateInputArgs({
    required this.name,
    required this.description,
    required this.location,
    required this.playersForInvite,
  });

  final String name;
  final String description;
  final String location;
  final List<int> playersForInvite;

  @override
  List<Object?> get props => [
        name,
        description,
        location,
        playersForInvite,
      ];
}
