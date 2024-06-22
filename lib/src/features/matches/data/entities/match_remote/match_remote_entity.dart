// TODO not sure if should have one entity for each type of data source or just one for both
// TODO possibly later use Equatable for this
import 'package:equatable/equatable.dart';
import 'package:five_on_4_mobile/src/features/players/data/entities/player_remote/player_remote_entity.dart';

class MatchRemoteEntity extends Equatable {
  const MatchRemoteEntity({
    required this.id,
    required this.title,
    required this.dateAndTime,
    required this.location,
    required this.description,
    // TODO bring this back
    // required this.organizer,
    // TODO add this later
    // required this.arrivingPlayers,
  });

  // TODO if we go with Freezed, which we will, fromJson will be here anyway
  factory MatchRemoteEntity.fromJson({
    required Map<String, dynamic> json,
  }) {
    final id = json["id"] as int;
    final title = json["title"] as String;
    final dateAndTime = json["dateAndTime"] as int;
    final location = json["location"] as String;
    final description = json["description"] as String;
    // final organizer = json["organizer"] as String;

    // TODO add this later
    // final arrivingPlayers = (json["arrivingPlayers"] as List<dynamic>)
    //     .cast<Map<String, dynamic>>()
    //     .map((e) => PlayerRemoteEntity.fromJson(json: e))
    //     .toList();

    return MatchRemoteEntity(
      id: id,
      title: title,
      dateAndTime: dateAndTime,
      location: location,
      description: description,
      // organizer: organizer,
      // arrivingPlayers: arrivingPlayers,
    );
  }

  final int id;
  final String title;
  final int dateAndTime;
  final String location;
  final String description;
  // final String organizer;
  // final List<PlayerRemoteEntity> arrivingPlayers;

  Map<String, dynamic> toJson() {
    // final jsonArrivingPlayers = arrivingPlayers.map((e) => e.toJson()).toList();
    return {
      "id": id,
      "title": title,
      "dateAndTime": dateAndTime,
      "location": location,
      "description": description,
      // "organizer": organizer,
      // "arrivingPlayers": jsonArrivingPlayers,
    };
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        title,
        dateAndTime,
        location,
        description,
        // organizer,
        // arrivingPlayers,
      ];
}
