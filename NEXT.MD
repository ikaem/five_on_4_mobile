1. write tests for search matches controller states
2. test in ui with hardcoded value
3. render received data 
4. create search matches input controller - same as for create match
5. search is triggered on button, not on input change - so no need for debounce
----------
1. add search screen tab for players - same as for matches
2. add layers for searching matches and players - backend will need to be implemented
3. check to make sure that controller stsate change does not delete input data reset - it probably will - if so, i guess text edit contriollers will need to be lifter up
4. will need inputs controller for search screen - one for matches, one for players