// TODO use freezed or equatable later
class MatchModel {
  const MatchModel({
    required this.id,
    required this.date,
    required this.name,
    required this.location,
    required this.organizer,
    required this.arrivingPlayers,
  });

  final int id;
  final DateTime date;
  final String name;
  final String location;
  final String organizer;
  final int arrivingPlayers;
}
