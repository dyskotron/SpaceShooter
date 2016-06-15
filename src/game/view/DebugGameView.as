package game.view
{

    import flash.ui.Mouse;
    import flash.utils.Dictionary;

    import game.model.GameObject;
    import game.model.IGameModel;
    import game.model.gameObject.components.collider.SquareColliderComponent;

    import starling.display.Quad;
    import starling.display.Sprite;

    public class DebugGameView extends Sprite
    {
        private var _gameObjectQuads: Dictionary;

        private var _gameModel: IGameModel;

        public function init(aGameModel: IGameModel): void
        {
            _gameModel = aGameModel;
            _gameObjectQuads = new Dictionary();

            for (var i: int = 0; i < _gameModel.numPlayers; i++)
            {
                goSpawnedHandler(_gameModel.getPlayerModelByID(i));
            }

            aGameModel.enemySpawnedSignal.add(goSpawnedHandler);
            aGameModel.bulletSpawnedSignal.add(goSpawnedHandler);
            aGameModel.obstacleSpawnedSignal.add(goSpawnedHandler);
            aGameModel.bonusSpawnedSignal.add(goSpawnedHandler);
            aGameModel.gameObjectRemovedSignal.add(gameObjectRemovedSignal);
            aGameModel.gameObjectHitSignal.add(gameObjectHitHandler);

            Mouse.hide();
        }

        public function redraw(aDeltaTime: int): void
        {
            var i: int;

            var gameObject: GameObject;
            var testQuad: Quad;

            /** UPDATE PLAYERS **/
            for (i = 0; i < _gameModel.numPlayers; i++)
            {
                gameObject = _gameModel.getPlayerModelByID(i);
                testQuad = _gameObjectQuads[gameObject];
                testQuad.x = SquareColliderComponent(gameObject.collider).bounds.x;
                testQuad.y = SquareColliderComponent(gameObject.collider).bounds.y;
                testQuad.rotation = gameObject.transform.rotation;
            }

            /** UPDATE BULLETS **/
            for (i = 0; i < _gameModel.playerBullets.length; i++)
            {
                gameObject = _gameModel.playerBullets[i];
                testQuad = _gameObjectQuads[gameObject];
                testQuad.x = SquareColliderComponent(gameObject.collider).bounds.x;
                testQuad.y = SquareColliderComponent(gameObject.collider).bounds.y;
                testQuad.rotation = testQuad.rotation;
            }

            for (i = 0; i < _gameModel.enemyBullets.length; i++)
            {
                gameObject = _gameModel.enemyBullets[i];
                testQuad = _gameObjectQuads[gameObject];
                testQuad.x = SquareColliderComponent(gameObject.collider).bounds.x;
                testQuad.y = SquareColliderComponent(gameObject.collider).bounds.y;
                testQuad.rotation = testQuad.rotation;
            }

            /** UPDATE ENEMIES **/
            for (i = 0; i < _gameModel.enemies.length; i++)
            {
                gameObject = _gameModel.enemies[i];
                testQuad = _gameObjectQuads[gameObject];
                testQuad.x = SquareColliderComponent(gameObject.collider).bounds.x;
                testQuad.y = SquareColliderComponent(gameObject.collider).bounds.y;
                testQuad.rotation = testQuad.rotation;
            }

            /** UPDATE BONUSES **/
            for (i = 0; i < _gameModel.bonuses.length; i++)
            {
                gameObject = _gameModel.bonuses[i];
                testQuad = _gameObjectQuads[gameObject];
                testQuad.x = SquareColliderComponent(gameObject.collider).bounds.x;
                testQuad.y = SquareColliderComponent(gameObject.collider).bounds.y;
                testQuad.rotation = testQuad.rotation;
            }

            /** UPDATE OBSTACLES **/
            for (i = 0; i < _gameModel.obstacles.length; i++)
            {
                gameObject = _gameModel.obstacles[i];
                testQuad = _gameObjectQuads[gameObject];
                testQuad.x = SquareColliderComponent(gameObject.collider).bounds.x;
                testQuad.y = SquareColliderComponent(gameObject.collider).bounds.y;
                testQuad.rotation = testQuad.rotation;
            }
        }

        public function destroy(): void
        {
            _gameModel.enemySpawnedSignal.remove(goSpawnedHandler);
            _gameModel.bulletSpawnedSignal.remove(goSpawnedHandler);
            _gameModel.obstacleSpawnedSignal.remove(goSpawnedHandler);
            _gameModel.bonusSpawnedSignal.remove(goSpawnedHandler);
            _gameModel.gameObjectRemovedSignal.remove(gameObjectRemovedSignal);
            _gameModel.gameObjectHitSignal.remove(gameObjectHitHandler);
        }

        // ---------------------------------- SIGNAL HANDLERS ---------------------------------- //

        private function goSpawnedHandler(gameObject: GameObject): void
        {
            var debugQuad: Quad = new Quad(gameObject.gameObjectVO.width, gameObject.gameObjectVO.height, 0xFF0000);
            debugQuad.alpha = 0.3;
            addChild(debugQuad);
            _gameObjectQuads[gameObject] = debugQuad;
        }

        private function gameObjectRemovedSignal(aGameObject: GameObject): void
        {
            var testQuad: Quad = _gameObjectQuads[aGameObject];

            if (testQuad)
            {
                if (testQuad.parent == this)
                {
                    removeChild(testQuad);
                    delete _gameObjectQuads[aGameObject];
                }
                else
                {
                    trace("_MO_", this, "Error: testQuad is not on stage", testQuad);
                }
            }
            else
            {
                trace("_MO_", this, "Error: testQuad for removed gameObject not present: ", _gameObjectQuads[aGameObject]);
            }
        }

        private function gameObjectHitHandler(aGameObject: GameObject, aHitPointsLost: uint): void
        {

            /* //todo:show exact point where collision happens
             if (_gameObjectQuads[aGameObject])
             GameObjectView(_gameObjectQuads[aGameObject]).hitAnim();
             else
             trace("_MO_", this, "Error: view for removed gameObject not present");
             */
        }
    }
}
