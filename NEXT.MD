1. start with support for match participation
   1. it should be a new table
   2. many to many -> player and match
      1. player should be able to join many matches
      2. match should have many players
   3. create table
   4. migrate
   5. add endpoint to join
      1. joining is me
      2. me can be retrieved from token possibly - if not too inconvenient
   6. get player
      1. will need to join player table with match participation table
         1. maybe limit to 5? 
         2. maybe in future get only future matches