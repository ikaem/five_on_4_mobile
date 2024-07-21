1. pass data from screen view to tab containers - search matches state, callback to search matches
2. also will need to pass info on loading and errors, and handle those states in containers, like it is done on home screen  and match screen and create match screen
3. render received data 
4. create search matches input controller - same as for create match
5. search is triggered on button, not on input change - so no need for debounce
----------
1. add search screen tab for players - same as for matches
2. add layers for searching matches and players - backend will need to be implemented
3. check to make sure that controller stsate change does not delete input data reset - it probably will - if so, i guess text edit contriollers will need to be lifter up
4. will need inputs controller for search screen - one for matches, one for players