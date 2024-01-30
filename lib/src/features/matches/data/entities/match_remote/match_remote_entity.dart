// TODO not sure if should have one entity for each type of data source or just one for both

// TODO possibly later use Equatable for this
class MatchRemoteEntity {
  MatchRemoteEntity({
    required this.id,
    required this.date,
    required this.name,
    required this.location,
    required this.organizer,
    required this.description,
    required this.arrivingPlayers,
  });

  final int id;
  final int date;
  final String name;
  final String location;
  final String organizer;
  final String description;
  // TODO not sure if this should be some Brief entity?
  final List<PlayerRemoteEntity> arrivingPlayers;
  // TODO add match description field here and into entitiry
}
