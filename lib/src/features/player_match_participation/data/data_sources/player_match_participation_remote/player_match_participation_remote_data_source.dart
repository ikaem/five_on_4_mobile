// TODO NOT SURE IF this should really have local data source
// because we realllllly dont want to store this data - result of this data will come with the player when we fetch them
// really, we dont want to store particpation info for all other players

// what we want to do, and that is different, to update iourseleves when we join or unjoin a match - but that is different - i guess some join or unjoin controller will then maybe reload the match - we will see - lets just make it work for now

// so now local data source here - we dont want to store any data coming from this response in some participation table yet

// but how would we then
// - store all players match participations?
// - store all players match participation stats?

// so lets say, we fetch player, and we get all stats with it - for each match
// how do we divide this data?
// - we can store all match participations in a table for player, but because there are multiuple matches, we would have to store it in a list or json in a column of player table
// if we do store it in a separate table, we would have to store player id, match id, and participation data
// and then we would have to actually do joins and stuff on mobile - which is not good? or is it?

// ok, screw it, lets just create a table for player match participation

abstract interface class PlayerMatchParticipationRemoteDataSource {
  // all of these would actually go to the same endpoint?
  // join match

  // unjoin match

  // invite to a match

// TODO dont forget that probably we will need to fetch this participation somehow after it is created
  Future<int> joinMatch({
    required int matchId,
    // TODO maybe it would be better to let backend get this from token, but for now it is this way
    required int playerId,
  });

  Future<int> unjoinMatch({
    required int matchId,
    required int playerId,
  });

  Future<int> inviteToMatch({
    required int matchId,
    required int playerId,
  });
}
