package game.model
{
    import game.controller.GameEndSignal;
    import game.controller.PhysicsUpdateSignal;
    import game.controller.playerControl.KeyController;
    import game.controller.playerControl.PlayerActionID;
    import game.controller.playerControl.TouchController;
    import game.model.gameObject.BonusGO;
    import game.model.gameObject.BulletGO;
    import game.model.gameObject.EnemyGO;
    import game.model.gameObject.ObstacleGO;
    import game.model.gameObject.PlayerShipGO;
    import game.model.gameObject.constants.PlayerShipType;
    import game.model.gameObject.vo.BonusVO;
    import game.model.gameObject.vo.EnemyVO;
    import game.model.gameObject.vo.ObstacleVO;
    import game.model.gameObject.vo.PlayerShipVO;
    import game.model.levelModel.LevelEvent;
    import game.model.levelModel.SpawnBonusEvent;
    import game.model.levelModel.SpawnEnemyEvent;
    import game.model.levelModel.SpawnObstacleEvent;

    import highScores.model.IHighScoreService;

    import main.model.IMainModel;
    import main.model.IViewModel;

    import org.osflash.signals.Signal;
    import org.robotlegs.mvcs.Actor;

    import starling.utils.MathUtil;

    public class GameModel extends Actor implements IGameModel
    {
        public static const MAX_PLAYERS: Number = 2;
        public static const SHIP_MOVE_BOUNDS: Number = 50;
        public static const OUTER_BOUNDS: Number = 150;

        public static const STATE_MOVING: uint = 0;
        public static const STATE_WAIT_FOR_CLEAR: uint = 1;
        public static const STATE_ENDED: uint = 1;

        private const ENEMY_HP_TO_SCORE_RATIO: Number = 1;
        private const OBSTACLE_HP_TO_SCORE_RATIO: int = 0.3;

        [Inject]
        public var touchController: TouchController;

        [Inject]
        public var keyController: KeyController;

        [Inject]
        public var gameEndSignal: GameEndSignal;

        [Inject]
        public var physicsUpdateSignal: PhysicsUpdateSignal;

        [Inject]
        public var viewModel: IViewModel;

        [Inject]
        public var mainModel: IMainModel;

        [Inject]
        public var levelModel: ILevelModel;

        [Inject]
        public var highScoreService: IHighScoreService;

        private var _playerBullets: Vector.<BulletGO>;
        private var _enemyBullets: Vector.<BulletGO>;
        private var _enemies: Vector.<EnemyGO>;
        private var _bonuses: Vector.<BonusGO>;
        private var _obstacles: Vector.<ObstacleGO>;

        private var _numPLayers: uint;

        private var _enemySpawnedSignal: Signal;
        private var _obstacleSpawnedSignal: Signal;
        private var _bonusSpawnedSignal: Signal;
        private var _bulletSpawnedSignal: Signal;

        private var _gameObjectRemovedSignal: Signal;
        private var _gameObjectHitSignal: Signal;

        private var _players: Vector.<PlayerShipGO>;

        private var _state: uint;
        private var _finishedLevel: Boolean = false;


        /**
         * Main model of the Game, it stores and updates all game objects, and dispatches according signal if something changes
         */
        public function GameModel()
        {
            super();
        }


        //region -------------------------------- SETTERS & GETTERS --------------------------------

        public function get numPlayers(): uint
        {
            return _numPLayers;
        }

        public function get finishedLevel(): Boolean
        {
            return _finishedLevel;
        }

        public function get playerBullets(): Vector.<BulletGO>
        {
            return _playerBullets;
        }

        public function get enemyBullets(): Vector.<BulletGO>
        {
            return _enemyBullets;
        }

        public function get enemies(): Vector.<EnemyGO>
        {
            return _enemies;
        }

        public function get bonuses(): Vector.<BonusGO>
        {
            return _bonuses;
        }

        public function get obstacles(): Vector.<ObstacleGO>
        {
            return _obstacles;
        }

        public function get enemySpawnedSignal(): Signal
        {
            return _enemySpawnedSignal;
        }

        public function get obstacleSpawnedSignal(): Signal
        {
            return _obstacleSpawnedSignal;
        }

        public function get bonusSpawnedSignal(): Signal
        {
            return _bonusSpawnedSignal;
        }

        public function get bulletSpawnedSignal(): Signal
        {
            return _bulletSpawnedSignal;
        }

        public function get gameObjectRemovedSignal(): Signal
        {
            return _gameObjectRemovedSignal;
        }

        public function get gameObjectHitSignal(): Signal
        {
            return _gameObjectHitSignal;
        }

        //endregion

        //region ---------------------------------- PUBLIC METHODS ---------------------------------


        public function getPlayerModelByID(aID: uint = 0): PlayerShipGO
        {
            return _players[aID];
        }

        public function init(): void
        {
            _numPLayers = MathUtil.clamp(mainModel.numPlayers, 1, MAX_PLAYERS);

            _enemySpawnedSignal = new Signal(EnemyGO);
            _bulletSpawnedSignal = new Signal(BulletGO);
            _obstacleSpawnedSignal = new Signal(ObstacleGO);
            _bonusSpawnedSignal = new Signal(BonusGO);

            _gameObjectRemovedSignal = new Signal(GameObject);
            _gameObjectHitSignal = new Signal(GameObject, int);

            _players = new Vector.<PlayerShipGO>();
            _enemies = new Vector.<EnemyGO>();
            _playerBullets = new Vector.<BulletGO>();
            _enemyBullets = new Vector.<BulletGO>();
            _bonuses = new Vector.<BonusGO>();
            _obstacles = new Vector.<ObstacleGO>();

            var player: PlayerShipGO;
            for (var i: int = 0; i < _numPLayers; i++)
            {
                player = new PlayerShipGO(i, new PlayerShipVO(PlayerShipType.BASIC_SHOOTER, 150, 99, 75));
                player.init((viewModel.gameWidth / (_numPLayers + 1)) * (i + 1), viewModel.gameHeight - SHIP_MOVE_BOUNDS);
                player.shootSignal.add(playerShootHandler);
                player.playerDiedSignal.add(playerDiedHandler);
                _players.push(player);
            }

            physicsUpdateSignal.add(gameLoopSignalHandler);

            touchController.positionChangeSignal.add(changePlayerPosition);
            keyController.directionChangeSignal.add(changePlayerDirection);

            touchController.actionSwitchSignal.add(actionSwitchHandler);
            keyController.actionSwitchSignal.add(actionSwitchHandler);

            levelModel.levelEventSignal.add(levelEventHandler);

            _state = STATE_MOVING;

            levelModel.init();
        }

        public function destroy(): void
        {
            trace(this, "========> MODEL - DESTROYED");
        }

        //endregion


        private function endGame(aFinished: Boolean): void
        {
            _finishedLevel = aFinished;
            gameEndSignal.dispatch();

            touchController.positionChangeSignal.remove(changePlayerPosition);
            keyController.directionChangeSignal.remove(changePlayerDirection);
            touchController.actionSwitchSignal.remove(actionSwitchHandler);
            keyController.actionSwitchSignal.remove(actionSwitchHandler);

            for (var i: int = 0; i < _players.length; i++)
            {
                if (_players[i].score > 0)
                    highScoreService.saveScore(mainModel.getPlayerName(i), _players[i].score);
                _players[i].endShoot();
            }
        }

        //region --------------------------------- SIGNAL HANDLERS ---------------------------------

        private function gameLoopSignalHandler(aDeltaTime: int): void
        {
            var i: int;
            var iC: int;

            var playerGO: PlayerShipGO;
            var enemyGO: EnemyGO;

            var enemyBulletGO: BulletGO;
            var playerBulletGO: BulletGO;

            var bonusGO: BonusGO;
            var obstacleGO: ObstacleGO;

            //UPDATE LEVEL
            if (_state == STATE_MOVING)
            {
                levelModel.progress(aDeltaTime);
            }

            //UPDATE ENEMIES
            for (i = 0; i < _enemies.length; i++)
            {
                enemyGO = _enemies[i];
                enemyGO.update(aDeltaTime);

                //TODO: rectangle contains instead
                if (_enemies[i].y > viewModel.stageHeight + OUTER_BOUNDS)
                {
                    _enemies.splice(i, 1);
                    _gameObjectRemovedSignal.dispatch(enemyGO);
                }
            }

            //UPDATE ENEMY BULLETS
            for (i = 0; i < _enemyBullets.length; i++)
            {
                enemyBulletGO = _enemyBullets[i];
                enemyBulletGO.update(aDeltaTime);

                //if bullet fits in bounds
                if (enemyBulletGO.y < viewModel.gameHeight + OUTER_BOUNDS)
                {
                    //check for collisions
                    for (iC = 0; iC < _players.length; iC++)
                    {
                        playerGO = _players[iC];

                        if (playerGO.state == PlayerShipGO.STATE_ALIVE && playerGO.bounds.intersects(enemyBulletGO.bounds))
                        {
                            //TODO: there should be next more accurate hitTest ideally pixel perfect collision(based on asset bitmapData)
                            //decrease hp
                            playerGO.hit(enemyBulletGO.bulletVO.damage);
                            _gameObjectHitSignal.dispatch(playerGO, 0);

                            //remove bullet & stop checking other players
                            _enemyBullets.splice(i, 1);
                            i--;
                            _gameObjectRemovedSignal.dispatch(enemyBulletGO);
                            break;
                        }
                    }
                }
                else
                {
                    //remove bullet
                    _enemyBullets.splice(i, 1);
                    i--;
                    _gameObjectRemovedSignal.dispatch(enemyBulletGO);
                }
            }


            //UPDATE PLAYER BULLETS
            bulletLoop: for (i = 0; i < _playerBullets.length; i++)
            {
                playerBulletGO = _playerBullets[i];
                playerBulletGO.update(aDeltaTime);

                //if bullet fits in bounds
                if (playerBulletGO.y > -OUTER_BOUNDS)
                {
                    //enemy collisions
                    for (iC = 0; iC < _enemies.length; iC++)
                    {

                        enemyGO = _enemies[iC];
                        if (enemyGO.bounds.intersects(playerBulletGO.bounds))
                        {
                            //TODO: there should be next more accurate hitTest ideally pixel perfect collision(based on asset bitmapData)
                            //decrease hp
                            enemyGO.hit(playerBulletGO.bulletVO.damage);
                            _gameObjectHitSignal.dispatch(enemyGO, 0);

                            //remove enemy if dead
                            if (enemyGO.hp <= 0)
                            {
                                _enemies.splice(iC, 1);
                                iC--;
                                _gameObjectRemovedSignal.dispatch(enemyGO);
                                _players[playerBulletGO.ownerID].score += enemyGO.enemyVO.initialHP * ENEMY_HP_TO_SCORE_RATIO;
                            }

                            //remove bullet & stop checking rest of enemies vector
                            _playerBullets.splice(i, 1);
                            i--;
                            _gameObjectRemovedSignal.dispatch(playerBulletGO);
                            continue bulletLoop;
                        }
                    }

                    //obstacle collisions
                    for (iC = 0; iC < _obstacles.length; iC++)
                    {
                        obstacleGO = _obstacles[iC];
                        if (obstacleGO.bounds.intersects(playerBulletGO.bounds))
                        {
                            //TODO: there should be next more accurate hitTest ideally pixel perfect collision(based on asset bitmapData)
                            //decrease hp
                            obstacleGO.hit(playerBulletGO.bulletVO.damage);
                            _gameObjectHitSignal.dispatch(obstacleGO, 0);

                            //remove obstacle if dead
                            if (obstacleGO.hp <= 0)
                            {
                                _obstacles.splice(iC, 1);
                                iC--;
                                _gameObjectRemovedSignal.dispatch(obstacleGO);
                                _players[playerBulletGO.ownerID].score += obstacleGO.obstacleVO.initialHP * OBSTACLE_HP_TO_SCORE_RATIO;
                            }

                            //remove bullet & stop checking rest of obstacles vector
                            _playerBullets.splice(i, 1);
                            i--;
                            _gameObjectRemovedSignal.dispatch(playerBulletGO);
                            continue bulletLoop;
                        }
                    }
                }
                else
                {
                    //remove bullet
                    _playerBullets.splice(i, 1);
                    i--;
                    _gameObjectRemovedSignal.dispatch(playerBulletGO);
                }
            }

            //UPDATE BONUSES
            for (i = 0; i < _bonuses.length; i++)
            {
                bonusGO = _bonuses[i];
                bonusGO.update(aDeltaTime);

                //TODO: rectangle contains instead
                if (_bonuses[i].y > viewModel.stageHeight + OUTER_BOUNDS)
                {
                    _bonuses.splice(i, 1);
                    _gameObjectRemovedSignal.dispatch(bonusGO);
                }
            }

            //UPDATE OBSTACLES
            for (i = 0; i < _obstacles.length; i++)
            {
                obstacleGO = _obstacles[i];
                obstacleGO.update(aDeltaTime);

                //TODO: rectangle contains instead
                if (_obstacles[i].y > viewModel.stageHeight + OUTER_BOUNDS)
                {
                    _obstacles.splice(i, 1);
                    _gameObjectRemovedSignal.dispatch(obstacleGO);
                }
            }

            // UPDATE PLAYERS
            for (i = 0; i < _numPLayers; i++)
            {
                playerGO = _players[i];
                if (playerGO.state == PlayerShipGO.STATE_ALIVE || playerGO.state == PlayerShipGO.STATE_SPAWNING)
                {
                    _players[i].update(aDeltaTime);

                    if (playerGO.state == PlayerShipGO.STATE_ALIVE)
                    {
                        //enemy collisions
                        for (iC = 0; iC < _enemies.length; iC++)
                        {
                            enemyGO = _enemies[iC];
                            if (enemyGO.bounds.intersects(playerGO.bounds))
                            {
                                //TODO: there should be next more accurate hitTest ideally pixel perfect collision(based on asset bitmapData)
                                //decrease player hp
                                playerGO.hit(enemyGO.enemyVO.initialHP);
                                _gameObjectHitSignal.dispatch(playerGO, enemyGO.enemyVO.initialHP);

                                _enemies.splice(iC, 1);
                                iC--;
                                _gameObjectRemovedSignal.dispatch(enemyGO);
                            }
                        }

                        //bonus collisions
                        for (iC = 0; iC < _bonuses.length; iC++)
                        {
                            bonusGO = _bonuses[iC];
                            if (bonusGO.bounds.intersects(playerGO.bounds))
                            {
                                //TODO: there should be next more accurate hitTest ideally pixel perfect collision(based on asset bitmapData)
                                //give player a bonus
                                playerGO.getBonus(bonusGO.bonusVO.typeID);

                                _bonuses.splice(iC, 1);
                                iC--;
                                _gameObjectRemovedSignal.dispatch(bonusGO);
                            }
                        }

                        //obstacle collisions
                        for (iC = 0; iC < _obstacles.length; iC++)
                        {
                            obstacleGO = _obstacles[iC];
                            if (obstacleGO.bounds.intersects(playerGO.bounds))
                            {
                                //TODO: there should be next more accurate hitTest ideally pixel perfect collision(based on asset bitmapData)
                                //decrease player hp
                                playerGO.hit(obstacleGO.obstacleVO.initialHP);
                                _gameObjectHitSignal.dispatch(playerGO, obstacleGO.obstacleVO.initialHP);

                                _obstacles.splice(iC, 1);
                                iC--;
                                _gameObjectRemovedSignal.dispatch(obstacleGO);
                            }
                        }
                    }
                }
            }
        }

        private function levelEventHandler(aLevelEvent: LevelEvent): void
        {
            switch (aLevelEvent.id)
            {
                case LevelEvent.ID_SPAWN_ENEMY:
                    var enemyEvent: SpawnEnemyEvent = SpawnEnemyEvent(aLevelEvent);
                    var enemyVO: EnemyVO = enemyEvent.aEnemyVO;
                    var enemy: EnemyGO = new EnemyGO(enemyVO, enemyEvent.x, enemyEvent.y, _players[0]);
                    enemy.shootSignal.add(enemyShootHandler);
                    _enemies.push(enemy);
                    _enemySpawnedSignal.dispatch(enemy);
                    break;

                case LevelEvent.ID_SPAWN_BONUS:
                    var bonusEvent: SpawnBonusEvent = SpawnBonusEvent(aLevelEvent);
                    var bonusVO: BonusVO = bonusEvent.aBonusVO;
                    var bonus: BonusGO = new BonusGO(bonusVO, bonusEvent.x, bonusEvent.y, 0, 0.1);
                    _bonuses.push(bonus);
                    _bonusSpawnedSignal.dispatch(bonus);
                    break;

                case LevelEvent.ID_SPAWN_OBSTACLE:
                    var obstacleEvent: SpawnObstacleEvent = SpawnObstacleEvent(aLevelEvent);
                    var obstacleVO: ObstacleVO = obstacleEvent.obstacleVO;
                    var obstacle: ObstacleGO = new ObstacleGO(obstacleVO, obstacleEvent.x, obstacleEvent.y, obstacleEvent.speedX, obstacleEvent.speedY, obstacleEvent.rotation);
                    _obstacles.push(obstacle);
                    _obstacleSpawnedSignal.dispatch(obstacle);
                    break;

                case LevelEvent.ID_PAUSE:
                    trace("_MO_", this, "pause until screen cleared");
                    break;

                case LevelEvent.ID_END:
                    trace("_MO_", this, "end of level");
                    endGame(true);
                    break;
            }
        }

        private function playerShootHandler(aBullets: Vector.<BulletGO>): void
        {
            for (var i: int = 0; i < aBullets.length; i++)
            {
                _playerBullets.push(aBullets[i]);
                _bulletSpawnedSignal.dispatch(aBullets[i]);
            }
        }

        private function enemyShootHandler(aBullets: Vector.<BulletGO>): void
        {
            for (var i: int = 0; i < aBullets.length; i++)
            {
                _enemyBullets.push(aBullets[i]);
                _bulletSpawnedSignal.dispatch(aBullets[i]);
            }
        }

        private function changePlayerDirection(aPlayerID: uint, aX: Number, aY: Number): void
        {
            aPlayerID = Math.min(aPlayerID, _numPLayers - 1);

            changePlayerPosition(aPlayerID, _players[aPlayerID].controlX + aX, _players[aPlayerID].controlY + aY);
        }

        private function changePlayerPosition(aPlayerID: uint, aX: Number, aY: Number): void
        {
            aPlayerID = Math.min(aPlayerID, _numPLayers - 1);

            _players[aPlayerID].controlX = MathUtil.clamp(aX, SHIP_MOVE_BOUNDS, viewModel.gameWidth - SHIP_MOVE_BOUNDS);
            _players[aPlayerID].controlY = MathUtil.clamp(aY, SHIP_MOVE_BOUNDS, viewModel.gameHeight - SHIP_MOVE_BOUNDS);
        }

        private function actionSwitchHandler(aPlayerID: uint, aActionID: uint, aValue: Boolean): void
        {
            aPlayerID = Math.min(aPlayerID, _numPLayers - 1);

            var playerGO: PlayerShipGO = _players[aPlayerID];

            switch (aActionID)
            {
                case PlayerActionID.SHOOT:
                    aValue ? playerGO.startShoot() : playerGO.endShoot();
                    break;
            }
        }

        private function playerDiedHandler(aPLayerID: uint): void
        {
            for (var i: int = 0; i < _players.length; i++)
            {
                if (_players[i].state != PlayerShipGO.STATE_DEAD)
                    return;
            }

            endGame(false);
        }

        //endregion
    }
}