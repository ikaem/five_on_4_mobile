import 'package:equatable/equatable.dart';

class MatchLocalEntityValue extends Equatable {
  const MatchLocalEntityValue({
    required this.id,
    required this.dateAndTime,
    required this.title,
    required this.location,
    required this.description,
  });

  final int id;
  final int dateAndTime;
  final String title;
  final String location;
  final String description;

  @override
  List<Object?> get props => [id, dateAndTime, title, location, description];
}
