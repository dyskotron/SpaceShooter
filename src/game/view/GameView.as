package game.view
{

    import common.model.TextureProvider;

    import flash.geom.Point;
    import flash.ui.Mouse;
    import flash.utils.Dictionary;

    import game.model.GameObject;
    import game.model.IGameModel;
    import game.model.gameObject.BonusGO;
    import game.model.gameObject.BulletGO;
    import game.model.gameObject.EnemyGO;
    import game.model.gameObject.ObstacleGO;
    import game.model.gameObject.PlayerShipGO;
    import game.view.gameObjectViews.BonusView;
    import game.view.gameObjectViews.BulletView;
    import game.view.gameObjectViews.EnemyShipView;
    import game.view.gameObjectViews.ExplosionAnim;
    import game.view.gameObjectViews.GameObjectView;
    import game.view.gameObjectViews.IGameObjectView;
    import game.view.gameObjectViews.ObstacleView;
    import game.view.gameObjectViews.PlayerShipView;
    import game.view.gameObjectViews.RocketView;

    import main.model.IViewModel;
    import main.view.SceneID;
    import main.view.SceneView;

    import starling.display.Image;
    import starling.display.Sprite;
    import starling.textures.Texture;

    public class GameView extends SceneView
    {
        private static var SCREENSHAKE_LENGTH: Number = 1000;
        private static var MAX_SCREENSHAKE: uint = 80;
        private static var HP_TO_SCREENSHAKE_RATIO: Number = 0.4;

        private var _guiViews: Vector.<GuiView>;
        private var _resultsView: ResultsView;

        private var _playerViews: Vector.<PlayerShipView>;

        private var _gameObjectViews: Dictionary;

        private var _gameModel: IGameModel;
        private var _textureProvider: TextureProvider;

        private var _gameLayer: Sprite;
        private var _miscLayer: Sprite;
        private var _shipsLayer: Sprite;
        private var _obstacleLayer: Sprite;
        private var _guiLayer: Sprite;
        private var _bgImage: Image;

        private var _bgTexCords: Vector.<Point>;
        private var _bgScrollSpeed: Number;
        private var _screenShake: int;
        private var _screenShakeDecrement: Number;

        public function GameView()
        {
            super(SceneID.GAME);
        }

        // ---------------------------------- PUBLIC METHODS ---------------------------------- //

        public function init(aViewModel: IViewModel, aTextureProvider: TextureProvider, aGameModel: IGameModel): void
        {
            _gameModel = aGameModel;
            _textureProvider = aTextureProvider;

            //background
            var bgTexture: Texture = _textureProvider.getBackroundTexture();
            _bgImage = new Image(bgTexture);
            _bgImage.width = aViewModel.gameWidth + MAX_SCREENSHAKE;
            _bgImage.height = aViewModel.gameHeight + MAX_SCREENSHAKE;
            _bgImage.x = _bgImage.y = -MAX_SCREENSHAKE;
            addChild(_bgImage);

            //save tex cords, so we can just update their y and set them to the image on redraw
            var scaleY: Number = bgTexture.width / _bgImage.width;
            var texCordY: Number = _bgImage.height / bgTexture.height * scaleY;

            _bgTexCords = new Vector.<Point>();
            _bgTexCords.push(new Point(0, 0));
            _bgTexCords.push(new Point(1, 0));
            _bgTexCords.push(new Point(0, texCordY));
            _bgTexCords.push(new Point(1, texCordY));
            _bgScrollSpeed = 120 / bgTexture.height;

            _gameLayer = new Sprite();
            _miscLayer = new Sprite();
            _shipsLayer = new Sprite();
            _obstacleLayer = new Sprite();
            _gameLayer.addChild(_bgImage);
            _gameLayer.addChild(_miscLayer);
            _gameLayer.addChild(_shipsLayer);
            _gameLayer.addChild(_obstacleLayer);
            addChild(_gameLayer);

            _guiLayer = new Sprite();
            addChild(_guiLayer);

            _guiViews = new Vector.<GuiView>();
            _playerViews = new Vector.<PlayerShipView>();

            _gameObjectViews = new Dictionary();

            var playerView: PlayerShipView;
            var playerGO: PlayerShipGO;
            for (var i: int = 0; i < _gameModel.numPlayers; i++)
            {
                //add player
                playerGO = _gameModel.getPlayerModelByID(i);
                playerView = new PlayerShipView(_textureProvider.getPlayerShipTexture(i));
                _shipsLayer.addChild(playerView);

                _playerViews[i] = playerView;
                _gameObjectViews[playerGO] = playerView;

                playerGO.changeStateSignal.add(playerChangeStateHandler);

                //gui
                var guiView: GuiView = new GuiView(i, aViewModel.stageWidth / 2, 40);
                _guiLayer.addChild(guiView);
                guiView.x = i * aViewModel.stageWidth / 2;
                _guiViews.push(guiView);
            }

            aGameModel.enemySpawnedSignal.add(enemySpawnedHandler);
            aGameModel.bulletSpawnedSignal.add(bulletSpawnedHandler);
            aGameModel.obstacleSpawnedSignal.add(obstacleSpawnedHandler);
            aGameModel.bonusSpawnedSignal.add(bonusSpawnedHandler);
            aGameModel.gameObjectRemovedSignal.add(gameObjectRemovedHandler);
            aGameModel.gameObjectHitSignal.add(gameObjectHitHandler);
            aGameModel.aoeDamageTriggeredSignal.add(aoeDamageTriggeredHandler);

            Mouse.hide();
            /*
             CONFIG::debug {
             addChild(new DebugGameView());
             Mouse.show();
             } */
        }

        public function showResults(): void
        {
            trace("_MO_", this, "showResults");
            for (var i: int = 0; i < _gameModel.numPlayers; i++)
            {
                _guiLayer.removeChild(_guiViews[i]);
                _guiViews[i] = null;
            }

            _resultsView = new ResultsView();
            _guiLayer.addChild(_resultsView);

            Mouse.show();
        }

        public function redraw(aDeltaTime: int): void
        {
            var i: int;

            /** UPDATE PLAYERS **/
            var playerModel: PlayerShipGO;
            var playerView: PlayerShipView;
            for (i = 0; i < _gameModel.numPlayers; i++)
            {
                playerModel = _gameModel.getPlayerModelByID(i);
                playerView = _playerViews[i];
                playerView.x = playerModel.x;
                playerView.y = playerModel.y;
                playerView.rotation = playerModel.rotation;
            }

            /** UPDATE BULLETS **/
            var bulletModel: BulletGO;
            var bulletView: IGameObjectView;
            for (i = 0; i < _gameModel.playerBullets.length; i++)
            {
                bulletModel = _gameModel.playerBullets[i];
                bulletView = _gameObjectViews[bulletModel];
                bulletView.x = bulletModel.x;
                bulletView.y = bulletModel.y;
                bulletView.rotation = bulletModel.rotation;
            }

            for (i = 0; i < _gameModel.enemyBullets.length; i++)
            {
                bulletModel = _gameModel.enemyBullets[i];
                bulletView = _gameObjectViews[bulletModel];
                bulletView.x = bulletModel.x;
                bulletView.y = bulletModel.y;
                bulletView.rotation = bulletModel.rotation;
            }

            /** UPDATE ENEMIES **/
            var enemyView: EnemyShipView;
            var enemyModel: EnemyGO;
            for (i = 0; i < _gameModel.enemies.length; i++)
            {
                enemyModel = _gameModel.enemies[i];
                enemyView = _gameObjectViews[enemyModel];
                enemyView.x = enemyModel.x;
                enemyView.y = enemyModel.y;
                enemyView.rotation = enemyModel.rotation;
            }

            /** UPDATE BONUSES **/
            var bonusModel: BonusGO;
            var bonusView: BonusView;
            for (i = 0; i < _gameModel.bonuses.length; i++)
            {
                bonusModel = _gameModel.bonuses[i];
                bonusView = _gameObjectViews[bonusModel];
                bonusView.x = bonusModel.x;
                bonusView.y = bonusModel.y;
                bonusView.rotation = bonusModel.rotation;
            }

            /** UPDATE OBSTACLES **/
            var obstacleModel: ObstacleGO;
            var obstacleView: ObstacleView;
            for (i = 0; i < _gameModel.obstacles.length; i++)
            {
                obstacleModel = _gameModel.obstacles[i];
                obstacleView = _gameObjectViews[obstacleModel];
                obstacleView.x = obstacleModel.x;
                obstacleView.y = obstacleModel.y;
                obstacleView.rotation = obstacleModel.rotation;
            }

            /** BACKGROUND **/

            var textCord: Point;
            for (i = 0; i < 4; i++)
            {
                textCord = _bgTexCords[i];
                textCord.y -= _bgScrollSpeed * aDeltaTime / 1000;
                _bgImage.setTexCoords(i, textCord);
            }

            if (_screenShake >= 0)
            {
                _gameLayer.x = Math.random() * _screenShake;
                _gameLayer.y = Math.random() * _screenShake;
                _screenShake -= _screenShakeDecrement * aDeltaTime;
            }
        }

        override public function destroy(): void
        {
            for (var i: int = 0; i < _gameModel.numPlayers; i++)
            {
                if (_guiViews[i])
                    _guiLayer.removeChild(_guiViews[i]);
            }
            _guiViews = null;

            _gameModel.enemySpawnedSignal.remove(enemySpawnedHandler);
            _gameModel.bulletSpawnedSignal.remove(bulletSpawnedHandler);
            _gameModel.obstacleSpawnedSignal.remove(obstacleSpawnedHandler);
            _gameModel.bonusSpawnedSignal.remove(bonusSpawnedHandler);
            _gameModel.gameObjectRemovedSignal.remove(gameObjectRemovedHandler);
            _gameModel.gameObjectHitSignal.remove(gameObjectHitHandler);
            _gameModel.aoeDamageTriggeredSignal.remove(aoeDamageTriggeredHandler);
        }

        // ---------------------------------- PRIVATE METHODS ---------------------------------- //

        private function screenShake(aValue: uint): void
        {
            _screenShake = Math.min(_screenShake + aValue, MAX_SCREENSHAKE);
            _screenShakeDecrement = _screenShake / SCREENSHAKE_LENGTH;
        }

        // ---------------------------------- SIGNAL HANDLERS ---------------------------------- //

        private function enemySpawnedHandler(aEnemyGO: EnemyGO): void
        {
            var enemyView: EnemyShipView = new EnemyShipView(_textureProvider.getEnemyTexture(aEnemyGO.enemyVO.bulletID));
            enemyView.width = aEnemyGO.enemyVO.width;
            enemyView.height = aEnemyGO.enemyVO.height;
            _shipsLayer.addChild(enemyView);
            _gameObjectViews[aEnemyGO] = enemyView;
        }

        private function bulletSpawnedHandler(aBulletGO: BulletGO): void
        {
            var textures: Vector.<Texture> = _textureProvider.getBulletTextures(aBulletGO.bulletVO.bulletID)

            var bulletView: IGameObjectView;

            if (textures.length == 1)
            {
                bulletView = new BulletView(textures[0]);
                _miscLayer.addChild(GameObjectView(bulletView));
            }
            else
            {
                bulletView = new RocketView(textures);
                _miscLayer.addChild(RocketView(bulletView));
                RocketView(bulletView).play();
            }

            _gameObjectViews[aBulletGO] = bulletView;
        }

        private function obstacleSpawnedHandler(aObstacleGO: ObstacleGO): void
        {
            var obstacleView: ObstacleView = new ObstacleView(_textureProvider.getObstacleTexture(aObstacleGO.obstacleVO.bulletID));
            _obstacleLayer.addChild(obstacleView);
            _gameObjectViews[aObstacleGO] = obstacleView;
        }

        private function bonusSpawnedHandler(aBonusGO: BonusGO): void
        {
            var bonusView: BonusView = new BonusView(_textureProvider.getBonusTexture(aBonusGO.bonusVO.bulletID));
            _miscLayer.addChild(bonusView);
            _gameObjectViews[aBonusGO] = bonusView;
        }

        private function gameObjectRemovedHandler(aGameObject: GameObject): void
        {

            if (_gameObjectViews[aGameObject])
            {
                var view: IGameObjectView = _gameObjectViews[aGameObject];
                view.remove();
                //TODO: pooling
                delete _gameObjectViews[aGameObject];

            }
            else
            {
                trace("_MO_", this, "Error: view for removed gameObject not present: ", _gameObjectViews[aGameObject]);
            }
        }

        private function gameObjectHitHandler(aGameObject: GameObject, aHitPointsLost: uint): void
        {
            if (_gameObjectViews[aGameObject])
                IGameObjectView(_gameObjectViews[aGameObject]).hitAnim();
            else
                trace("_MO_", this, "Error: view for removed gameObject not present");

            if (aGameObject is PlayerShipGO)
            {
                screenShake(aHitPointsLost * HP_TO_SCREENSHAKE_RATIO);
            }
        }

        private function aoeDamageTriggeredHandler(aBulletGO: BulletGO): void
        {
            var explosionAnim: ExplosionAnim = new ExplosionAnim(_textureProvider.getExplosionTextures(0), aBulletGO.bulletVO.aoeDistance * 2);
            explosionAnim.x = aBulletGO.x;
            explosionAnim.y = aBulletGO.y;
            _miscLayer.addChild(explosionAnim);
            screenShake(20);
        }

        private function playerChangeStateHandler(aPlayerShipGO: PlayerShipGO): void
        {
            var playerView: PlayerShipView = _playerViews[aPlayerShipGO.playerID];

            switch (aPlayerShipGO.state)
            {
                case PlayerShipGO.STATE_ALIVE:
                    playerView.alpha = 1;
                    break;
                case PlayerShipGO.STATE_SPAWNING:
                    playerView.alpha = 0.2;
                    break;
                case PlayerShipGO.STATE_WAITING:
                case PlayerShipGO.STATE_DEAD:
                    playerView.alpha = 0;
                    break;
            }
        }
    }
}
