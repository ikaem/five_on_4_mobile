import 'package:equatable/equatable.dart';

/// Class to serve as a proxy between Drift used in data source and the domain layer that uses model
///
/// This is so as not to depend on the Drift library in the domain layer in case we want to change the database library
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
