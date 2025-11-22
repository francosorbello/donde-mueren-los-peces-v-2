# Room connection system

Currently, the world can respond to events and store that information so it persists between playtroughs.
The act of activating a lever is saved so when the player returns to that room later this action is still true.

This is useful to store certain events, like picking up abilities or interacting with npcs.
However, there are situations where we only want to make temporary changes that should be reversed when the player exists
the room. A common example is a timed lever, that changes the state for a small period of time. 
For situations like this, we can use the room connection system.