// TODO not sure if should have one entity for each type of data source or just one for both
// TODO possibly later use Equatable for this
import 'package:five_on_4_mobile/src/features/players/data/entities/player_remote/player_remote_entity.dart';
import 'package:flutter/widgets.dart';

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
  final List<PlayerRemoteEntity> arrivingPlayers;

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

  @visibleForTesting
  Map<String, dynamic> toJson() {
    final jsonArrivingPlayers = [];
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
}
