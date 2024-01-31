// TODO not sure if should have one entity for each type of data source or just one for both
// TODO possibly later use Equatable for this
import 'package:equatable/equatable.dart';
import 'package:five_on_4_mobile/src/features/players/data/entities/player_remote/player_remote_entity.dart';

class MatchRemoteEntity extends Equatable {
  const MatchRemoteEntity({
    required this.id,
    required this.date,
    required this.name,
    required this.location,
    required this.organizer,
    required this.description,
    required this.arrivingPlayers,
  });

  // TODO if we go with Freezed, which we will, fromJson will be here anyway
  factory MatchRemoteEntity.fromJson({
    required Map<String, dynamic> json,
  }) {
    final id = json["id"] as int;
    final date = json["date"] as int;
    final name = json["name"] as String;
    final location = json["location"] as String;
    final organizer = json["organizer"] as String;
    final description = json["description"] as String;
    // TODO temp for now
    final arrivingPlayers = <PlayerRemoteEntity>[];

    return MatchRemoteEntity(
      id: id,
      date: date,
      name: name,
      location: location,
      organizer: organizer,
      description: description,
      arrivingPlayers: arrivingPlayers,
    );
  }

  final int id;
  final int date;
  final String name;
  final String location;
  final String organizer;
  final String description;
  final List<PlayerRemoteEntity> arrivingPlayers;

  Map<String, dynamic> toJson() {
    final jsonArrivingPlayers = arrivingPlayers.map((e) => e.toJson()).toList();
    return {
      "id": id,
      "date": date,
      "name": name,
      "location": location,
      "organizer": organizer,
      "description": description,
      "arrivingPlayers": jsonArrivingPlayers,
    };
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        date,
        name,
        location,
        organizer,
        description,
        arrivingPlayers,
      ];
}
