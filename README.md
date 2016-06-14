# Space Shooter
Simple space vertical scrolling shooter game.


##Main Framework
As a base for this project I used my template I developed over time by doing prototypes or full apps / games. This framework is based on Robotlegs, with Starling and Signals plugins and for UI I use Feathers. Most of the time when I do something new I tend to add something, so this time I added a simple finite state machine. For most things I like to use Robotlegs' controller layer -Commands - a nice and efficient way, but for the main app states I wanted to find a nice solution which handles all transitions, initializes and maps everything in one place, instead of chaining a lot of commands. 

##Core Game Loop Classes
* GameLoopDispatcher - The class responsible for dispatching physics and view update signals.
* GameModel - The model which holds references to and updates all GameObjects and LevelModel, as well as dispatches signals when some important events happen in the game.
* GameObject - The model which represents all objects appearing in the game e.g. player ship, enemy ships, obstacles etc.
* GameView - The main view class holding references to and updating all GameObjectViews.
* GameObjectView - The visual representation of the GameObject.
* LevelModel - The model which keeps track of what should happen and dispatches signals as players go through the level.
* GameOjectVO - The ValueObject holds the definition of the GameObject, and holds properties which are not changing and / or are common for certain types of GameObjects.
* GameObjectDefs - Helper classes which create and store collections of GameOjectVOs.


##Core Game Loop 
When GameLoopDispatcher.start() is called in GameState.start() method, it dispatches PhysicsUpdateSignal followed by ViewUpdateSignal, it is not necessarily crucial for this game, but I found it useful a couple of times to put the updating model and the view of the game in this specific order. 
GameModel listens to PhysicsUpdateSignal, updates all GameObjects and LevelModel accordingly, and when Level Model dispatches LevelEventSignal, GameModel either changes its data, creates new GameObjects as needed, ends the level, or changes its state.
GameView holds reference to GameModel, and when ViewUpdateSignal is dispatched it updates all GameObjectViews based on GameModel’s GameOjectVOs. It also listens to various GameModel signals, to know when new GameObjectViews need to be created or destroyed. Having View and Model tightly coupled like this is not a common way how to do things in Robotlegs or in a MVC pattern in general, but it's necessary in order to avoid as much overhead as possible in the game loop as well as the events which happen often in the game. It would be a big performance loss if, for example, every bullet shot created a command and went through mediator to view.


##Next Steps
I haven’t implemented everything I want to, yet, so i'll just briefly describe my thoughts and ideas about what could be added or done better.

* I would definitely consider pooling GameObjects and its views, at least ones that are created and destroyed often, like bullets for example.
* I would inline more stuff in main update functions. Nicely organized object oriented code, which is broken down into objects and methods is easier to read and easier to manage, but calling Method is expensive and it can make a difference in the nested loops happening in each frame. I would also implement and test [Inline] meta tags introduced in ASC 2.0.
* As the whole game is on the client side and there is no server which can check whether or not the game state or the data going to the leaderboards is correct, it would make sense to protect crucial data in memory, which can easily be changed outside of the game. This can be done by implementing class, which would store value twice, first as a normal variable and secondly as some hash of that value. If the game tried to get this variable it would check if these values matched, and react accordingly if not (stop sending leaderboards data, ban user etc.) It's not laserproof, but it helps against basic hacking.
* The size for GameObject’s bounds is taken from texture. As a simple, fast solution it works, and it does not affect performance that much, as this is done before the game starts, but a nicer way of doing this would be taking values directly from sprite sheet’s XML.
* Collisions are a really simple rectangular bounds check. There should be a pixel perfect collision based on GameObject’s BitmapData, but as this is really CPU expensive, it should be placed inside of the existing check, instead of replacing it, to avoid doing this for all objects in every game loop.