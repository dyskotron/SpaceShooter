# Space Shooter
Simple space vertical scrolling shooter game.


##Main Framework
As a base for this project i used my template i developed over time by doing prototypes or full apps / games. This framework is based on Robotlegs, with Starling and Signals plugins and for UI i am using Feathers. Most of the time when i do something new i tend to add something, so this time i added simple finite state machine, for most things i like robolegs way of controller layer - commands - nice and efficient way, but for main app states i wanted to nice solution which handles all transitions, initializes and map everything on one place, instead of chaining lot of commands. 

##Core Game Loop Classes
* GameLoopDispatcher - Class responsible for dispatching physics and view update signals.
* GameModel - Model holding references to and updating all GameObjects, LevelModel and dispatching signals when some important events happen in a game.
* GameOject - model which represents all objects appearing in game e.g. player ship, enemy ships, obstacles etc.
* GameView - Main View class holding references to and updating all GameObjectViews.
* GameObjectView - Visual representation of GameObject
* LevelModel - Model which keeping track of what should happen and dispatches signals as players go through level.
* GameOjectVO - ValueObject holidng definition for GameObject, it holds properties which are not changing or / and are common for a certain type GameObjects
* GameObjectDefs - Helper classes which creates and stores collections of GameOjectVOs.


##Core Game Loop 
When GameLoopDispatcher.start() is called in GameState.start() method, it dispatches PhysicsUpdateSignal followed by ViewUpdateSignal, it maybe would not be crucial for this game, but i found it useful couple of times to have always given order of updating model and then view of a game. 
GameModel listens to PhysicsUpdateSignal, update all GameObjects and LevelModel acordingly, if Level Model dispatches LevelEventSignal GameModel change its data, creates new GameObjects needed, ending the level or change its state.
GameView holds reference to GameModel, when ViewUpdateSignal is dispatches it update all GameObjectViews based on GameModel’s GameOjectVOs, it also listens to various GameModel signals, when new GameObjectViews needs to be created or destroyed. Having View and Model tightly coupled like this is not common way how to do things in Robotlegs or in MVC pattern in general, but its necessary to avoid all overhead possible in game loop and events happening often in a game, it would be big performance loss if for example every bullet shoot would create command and going through mediator to view.


##Next Steps
I haven’t implemented all stuff i wanted so ill just briefly describe what are my tought and ideas what could be added or done better.

* I would definitely consider pooling gameObjets and its views, at least ones that are created and destroyed often like bullets for example.
* I would inline more stuff in main update functions, nicely organized object oriented code, break down to objects and method is nicely readible and easier to manage, but calling Method is expensive and in nested loops happening in each frame, it can make a difference. I would also implement and test [Inline] meta tags introduced in ASC 2.0
* As Game is whole on client side and there is no server which could check correct game state and if data going to leaderboards are correct, it would make sense to protect crucial data in memory which can be easily changed outside of game, That can be done by implemetning clas which would store value twice, once as normal variable and secondly as some hash of that value, when game vould try to get this variable it would check if these values match, and react accordingly if not(stop sending leaderboards data, ban user etc) Its not laserproof but it helps again basic hacking.
* Size for GameObject’s bounds is taken from texture, as simple fast solution it works, and it does not affect performance that much as this is done before game starts, but nicer way of doing this would be taking values directly from sprite sheet’s XML.
* Collisions - collisions are really simple rectangular bounds check, there should be pixel perfect collision based on GameObject’s BitmapData as this is really CPU expensive, it should be placed inside of existing check,not instead, to avoid doing this for all objects in every game loop.