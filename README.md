# TASKK APP

*Manage issues on Urbit*

<img src="http://i.imgur.com/lvsnIlT.png" width="100%"/>

## Design considerations

Will use clay as our shared state. This will allow multiple users to sync issues, 
etc. The basic unit of the app is the issue, which will be stored as an md file. 
As much as possible should be encoded in the file path, so that app functions as 
a wrapper around clay to enforce rules, etc.

(If there's a real need for real-timeness, it might be better to build on talk)

Any large-scale edits should be done in vim or a similar editor.

## Install
1. Copy /app/taskk.hoon to `%/app/taskk.hoon` on your ship
2. Run `|start %taskk`. *Note* This only needs to be done once.
3. Install taskk-ui, which is included as a git submodule. Make sure that the 
submodule has been properly dl-ed by running `git submodule update --init --recursive`
4. Follow [instructions](https://github.com/vvisigoth/taskk-ui) to install and run 
the front-end on your ship.

## User stories
+ start a board
+ edit an issue
+ delete an issue
+ add an issue to an existing board
+ subscribe to a board
+ assign an issue to someone else 
+ join an existing board
+ be updated when a board I subscribe to updates

## TODO
- [x] Create new board
- [x] Create new issue
- [x] Change issue phase
- [x] Change assignee
- [x] update front end on issue creation
- [ ] update front end when issue has been edited from back end
- [x] back end for delete
+ [ ] notify assignee on change
- [x] refactor js
- [x] react
- [ ] refactor hoon

