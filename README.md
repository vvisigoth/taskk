# TASK APP

*Manage issues on Urbit*

## Design considerations

Will use clay as our shared state. This will allow multiple users to sync issues, 
etc. The basic unit of the app is the issue, which will be stored as an md file. 
As much as possible should be encoded in the file path, so that app functions as 
a wrapper around clay to enforce rules, etc.

(If there's a real need for real-timeness, it might be better to build on talk)

Any large-scale edits should be done in vim or a similar editor.

Ideally, everything should be accessible from command line, preferably as a 
:talk-like console app. Probably would be easier to get a web interface going 
first (weirdly).

## User stories
+ I want to start a board
+ I want to add an issue to an existing board
+ I want to subscribe to a board
+ I want to assign an issue to someone else
+ I want to join an existing board
+ I want to be updated when a board I subscribe to updates

## Issue format
+ Board
+ Title
+ Issue number
+ Body text (md)
+ Author
+ Subscribers?
+ Assignee
+ Phase
+ Tags

## Dev "plan"
- [x] Create new board
- [x] Create new issue
- [] Change issue phase
- [] Change assignee
+ [] New issubscriptions
+ [] issue subscriptions

