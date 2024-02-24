import 'package:equatable/equatable.dart';

class MatchCreateDataValue extends Equatable {
  const MatchCreateDataValue({
    // required this.date,
    required this.name,
    required this.location,
    required this.organizer,
    required this.description,
    required this.invitedPlayers,
  });

  // final int date;
  final String name;
  final String location;
// TODO get this from use case inside the controller to get name of the current user
  final String organizer;
  final String description;
// TODO for now this is arriving players - and will be empty for now because we will not be ading players for now
  final List<int> invitedPlayers;

  Map<String, dynamic> toJson() {
    // TODO temp only for fake server
    // return {
    //   "ok": true,
    //   "data": {
    //     "date": date,
    //     "name": name,
    //     "location": location,
    //     "organizer": organizer,
    //     "description": description,
    //     "invitedPlayers": invitedPlayers,
    //     "id": 1,
    //   },
    // };

    return {
      // "date": date,
      "name": name,
      "location": location,
      "organizer": organizer,
      "description": description,
      "invitedPlayers": invitedPlayers,
      // TODO temp only for fake server
      // "id": 1,
    };
  }

  @override
  List<Object> get props => [
        // date,
        name,
        location,
        organizer,
        description,
        invitedPlayers,
      ];
}
