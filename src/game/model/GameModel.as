package game.model
{
    import com.greensock.TweenLite;

    import flash.geom.Rectangle;

    import game.controller.GameEndSignal;
    import game.controller.PhysicsUpdateSignal;
    import game.controller.playerControl.ITouchController;
    import game.controller.playerControl.KeyController;
    import game.controller.playerControl.PlayerActionID;
    import game.model.gameObject.BonusGO;
    import game.model.gameObject.BulletGO;
    import game.model.gameObject.EnemyGO;
    import game.model.gameObject.ObstacleGO;
    import game.model.gameObject.PlayerShipGO;
    import game.model.gameObject.components.collider.IOnceColliderComponent;
    import game.model.gameObject.components.controll.WeaponControlComponent;
    import game.model.gameObject.components.health.HealthState;
    import game.model.gameObject.components.health.IHealthComponent;
    import game.model.gameObject.components.health.PlayerHealthComponent;
    import game.model.gameObject.components.weapon.IWeaponDefs;
    import game.model.gameObject.components.weapon.enums.PlayerWeaponID;
    import game.model.gameObject.constants.BonusTypeID;
    import game.model.gameObject.constants.BulletMode;
    import game.model.gameObject.def.IBehaviorFactory;
    import game.model.gameObject.def.IPlayerShipDefs;
    import game.model.gameObject.fsm.ITarget;
    import game.model.gameObject.fsm.ITargetProvider;
    import game.model.gameObject.fsm.Target;
    import game.model.gameObject.fsm.TargetType;
    import game.model.gameObject.vo.BonusVO;
    import game.model.gameObject.vo.EnemyVO;
    import game.model.gameObject.vo.ObstacleVO;
    import game.model.levelModel.LevelEvent;
    import game.model.levelModel.SpawnBonusEvent;
    import game.model.levelModel.SpawnEnemyEvent;
    import game.model.levelModel.SpawnObstacleEvent;
    import game.model.playerModel.IPlayerModel;

    import highScores.model.IHighScoreService;

    import main.model.IMainModel;
    import main.model.IViewModel;

    import org.osflash.signals.Signal;
    import org.robotlegs.mvcs.Actor;

    import starling.utils.MathUtil;

    public class GameModel extends Actor implements IGameModel, ITargetProvider
    {
        public static const MAX_PLAYERS: Number = 2;
        public static const SHIP_MOVE_BOUNDS: Number = 50;
        public static const OUTER_BOUNDS: Number = 150;

        public static const STATE_MOVING: uint = 0;
        public static const STATE_WAIT_FOR_CLEAR: uint = 1;
        public static const STATE_ENDED: uint = 1;

        private const ENEMY_HP_TO_SCORE_RATIO: Number = 1;
        private const OBSTACLE_HP_TO_SCORE_RATIO: Number = 0.3;

        [Inject]
        public var touchController: ITouchController;

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
        public var playerModel: IPlayerModel;

        [Inject]
        public var behaviorFactory: IBehaviorFactory;

        [Inject]
        public var weaponDef: IWeaponDefs;

        [Inject]
        public var playerShipDef: IPlayerShipDefs;

        [Inject]
        public var levelProvider: ILevelProvider;

        [Inject]
        public var highScoreService: IHighScoreService;

        private var _levelModel: ILevelModel;

        private var _playerBullets: Vector.<BulletGO>;
        private var _playerAoeBullets: Vector.<BulletGO>;
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
        private var _aoeDamageTriggeredSignal: Signal;
        private var _gameObjectHitSignal: Signal;

        private var _players: Vector.<PlayerShipGO>;

        private var _state: uint;
        private var _finishedLevel: Boolean = false;
        private var _immortal: Boolean = false;
        private var _gameBounds: Rectangle;
        private var _playerHealth: Vector.<PlayerHealthComponent>;
        private var _playerWeapons: Vector.<WeaponControlComponent>;

        /**
         * Main model of the Game, it stores and updates all game objects, and dispatches according signals if something changes
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

        public function get aoeDamageTriggeredSignal(): Signal
        {
            return _aoeDamageTriggeredSignal;
        }

        //endregion

        //region ---------------------------------- PUBLIC METHODS ---------------------------------

        public function init(): void
        {
            _numPLayers = MathUtil.clamp(mainModel.numPlayers, 1, MAX_PLAYERS);

            _enemySpawnedSignal = new Signal(EnemyGO);
            _bulletSpawnedSignal = new Signal(BulletGO);
            _obstacleSpawnedSignal = new Signal(ObstacleGO);
            _bonusSpawnedSignal = new Signal(BonusGO);

            _gameObjectRemovedSignal = new Signal(GameObject);
            _gameObjectHitSignal = new Signal(GameObject, int);
            _aoeDamageTriggeredSignal = new Signal(BulletGO);

            _players = new Vector.<PlayerShipGO>();
            _playerWeapons = new Vector.<WeaponControlComponent>();
            _playerHealth = new Vector.<PlayerHealthComponent>();

            _enemies = new Vector.<EnemyGO>();
            _playerBullets = new Vector.<BulletGO>();
            _playerAoeBullets = new Vector.<BulletGO>();
            _enemyBullets = new Vector.<BulletGO>();
            _bonuses = new Vector.<BonusGO>();
            _obstacles = new Vector.<ObstacleGO>();

            _gameBounds = new flash.geom.Rectangle(-OUTER_BOUNDS, -OUTER_BOUNDS, viewModel.gameWidth + 2 * OUTER_BOUNDS, viewModel.gameHeight + 2 * OUTER_BOUNDS);

            var player: PlayerShipGO;
            var playerWeapon: WeaponControlComponent;
            var playerHealth: PlayerHealthComponent;

            for (var i: int = 0; i < _numPLayers; i++)
            {
                player = new PlayerShipGO(i, playerShipDef.getPlayerShip(playerModel.shipBuild), this);
                player.init((viewModel.gameWidth / (_numPLayers + 1)) * (i + 1), viewModel.gameHeight - SHIP_MOVE_BOUNDS);
                player.healthComponent.changeStateSignal.add(playerHealthHandler);
                _players.push(player);

                playerWeapon = WeaponControlComponent(player.getComponent(WeaponControlComponent));
                playerWeapon.shootSignal.add(playerShootHandler);
                _playerWeapons.push(playerWeapon);

                playerHealth = PlayerHealthComponent(player.getComponent(PlayerHealthComponent));
                playerHealth.changeStateSignal.add(playerHealthHandler);
                _playerHealth.push(playerHealth);

            }

            physicsUpdateSignal.add(gameLoopSignalHandler);

            touchController.positionChangeSignal.add(changePlayerPosition);
            keyController.directionChangeSignal.add(changePlayerDirection);

            touchController.actionSwitchSignal.add(actionSwitchHandler);
            keyController.actionSwitchSignal.add(actionSwitchHandler);

            touchController.actionTriggerSignal.add(actionTriggerHandler);
            keyController.actionTriggerSignal.add(actionTriggerHandler);

            _levelModel = levelProvider.getLevel(0);
            _levelModel.levelEventSignal.add(levelEventHandler);

            _state = STATE_MOVING;
        }

        public function destroy(): void
        {
            trace(this, "========> MODEL - DESTROYED");
        }

        public function getPlayerModelByID(aID: uint = 0): PlayerShipGO
        {
            return _players[aID];
        }

        public function getTarget(aTargetType: uint, aX: Number = 0, aY: Number = 0, aOrigAngle: Number = 0): ITarget
        {
            var i: int = 0;
            var target: ITarget;

            switch (aTargetType)
            {
                case TargetType.PLAYER:
                    return getRandomPlayer().transform;
                    break;
                case TargetType.EASIEST:
                    var currDelta: Number;
                    var smallestDelta: Number = Math.PI;
                    for (i = 0; i < _enemies.length; i++)
                    {
                        currDelta = Math.abs(Target.getAngleDelta(_enemies[i].transform, aX, aY, aOrigAngle));
                        if (smallestDelta > currDelta)
                        {
                            smallestDelta = currDelta;
                            target = _enemies[i].transform;
                        }
                    }
                    for (i = 0; i < _obstacles.length; i++)
                    {
                        currDelta = Math.abs(Target.getAngleDelta(_obstacles[i].transform, aX, aY, aOrigAngle));
                        if (smallestDelta > currDelta)
                        {
                            smallestDelta = currDelta;
                            target = _obstacles[i].transform;
                        }
                    }
                    break;
                case TargetType.OLDEST:
                    if (_enemies.length > 0)
                        target = _enemies[0].transform;
                    else if (_obstacles.length > 0)
                        target = _obstacles[0].transform;
                    break;
                case TargetType.NEWEST:
                    if (_enemies.length > 0)
                        target = _enemies[_enemies.length - 1].transform;
                    else if (_obstacles.length > 0)
                        target = _obstacles[_obstacles.length - 1].transform;
                    break;
                case TargetType.RANDOM:
                    if (_enemies.length > 0)
                        target = _enemies[Math.floor(Math.random() * _enemies.length)].transform;
                    else if (_obstacles.length > 0)
                        target = _obstacles[Math.floor(Math.random() * _obstacles.length)].transform;
                    break;
                case TargetType.BIGGEST_HP:
                    var currHP: Number;
                    var smallestHP: Number = Math.PI;
                    for (i = 0; i < _enemies.length; i++)
                    {
                        currHP = _enemies[i].healthComponent.hp;
                        if (smallestHP > currHP)
                        {
                            smallestHP = currHP;
                            target = _enemies[i].transform;
                        }
                    }
                    for (i = 0; i < _obstacles.length; i++)
                    {
                        currHP = _obstacles[i].healthComponent.hp;
                        if (smallestHP > currHP)
                        {
                            smallestHP = currHP;
                            target = _obstacles[i].transform;
                        }
                    }
                    break;
            }

            return target;
        }

        //endregion

        private function getRandomPlayer(): PlayerShipGO
        {
            return _players[Math.floor(Math.random() * _players.length)];
        }

        private function endGame(aFinished: Boolean): void
        {
            _finishedLevel = aFinished;
            gameEndSignal.dispatch();

            touchController.positionChangeSignal.remove(changePlayerPosition);
            keyController.directionChangeSignal.remove(changePlayerDirection);

            touchController.actionSwitchSignal.remove(actionSwitchHandler);
            keyController.actionSwitchSignal.remove(actionSwitchHandler);

            touchController.actionTriggerSignal.remove(actionTriggerHandler);
            keyController.actionTriggerSignal.remove(actionTriggerHandler);

            for (var i: int = 0; i < _players.length; i++)
            {
                if (_players[i].score > 0)
                    highScoreService.saveScore(mainModel.getPlayerName(i), _players[i].score);

                _playerWeapons[i].endShoot();
            }

            _state = STATE_ENDED;
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

            var removeBullet: Boolean;

            //region UPDATE LEVEL
            switch (_state)
            {
                case STATE_MOVING:
                    _levelModel.progress(aDeltaTime);
                    break;
                case STATE_WAIT_FOR_CLEAR:
                    if (_enemies.length + _obstacles.length == 0)
                        _state = STATE_MOVING;
                    break;
            }
            //endregion

            //region UPDATE PLAYERS
            for (i = 0; i < _numPLayers; i++)
            {
                playerGO = _players[i];
                if (playerGO.state == HealthState.ALIVE || playerGO.state == HealthState.SPAWNING)
                {
                    _players[i].update(aDeltaTime);

                    if (playerGO.state == HealthState.ALIVE)
                    {
                        //bonus collisions
                        for (iC = _bonuses.length - 1; iC >= 0; iC--)
                        {
                            bonusGO = _bonuses[iC];
                            if (playerGO.collider.checkCollision(bonusGO.collider))
                            {
                                //give player a bonus
                                getBonus(playerGO.playerID, bonusGO.bonusVO.bulletID);

                                _bonuses.splice(iC, 1);
                                _gameObjectRemovedSignal.dispatch(bonusGO);
                            }
                        }

                        if (!_immortal)
                        {
                            //enemy collisions
                            for (iC = _enemies.length - 1; iC >= 0; iC--)
                            {
                                enemyGO = _enemies[iC];
                                if (playerGO.collider.checkCollision(enemyGO.collider))
                                {
                                    //decrease player hp
                                    playerGO.healthComponent.hit(enemyGO.enemyVO.initialHP);
                                    _gameObjectHitSignal.dispatch(playerGO, enemyGO.enemyVO.initialHP);

                                    //remove enemy
                                    _enemies.splice(iC, 1);
                                    _gameObjectRemovedSignal.dispatch(enemyGO);
                                }
                            }

                            //enemy bullet collisions
                            for (iC = _enemyBullets.length - 1; iC >= 0; iC--)
                            {
                                enemyBulletGO = _enemyBullets[iC];

                                if (playerGO.collider.checkCollision(enemyBulletGO.collider))
                                {
                                    //decrease player hp
                                    playerGO.healthComponent.hit(enemyBulletGO.bulletVO.damage);
                                    _gameObjectHitSignal.dispatch(playerGO, 0);

                                    //remove bullet
                                    _enemyBullets.splice(iC, 1);
                                    _gameObjectRemovedSignal.dispatch(enemyBulletGO);
                                    break;
                                }
                            }

                            //obstacle collisions
                            for (iC = _obstacles.length - 1; iC >= 0; iC--)
                            {
                                obstacleGO = _obstacles[iC];
                                if (playerGO.collider.checkCollision(obstacleGO.collider))
                                {
                                    //decrease player hp
                                    playerGO.healthComponent.hit(obstacleGO.obstacleVO.initialHP);
                                    _gameObjectHitSignal.dispatch(playerGO, obstacleGO.obstacleVO.initialHP);

                                    //remove obstacle
                                    _obstacles.splice(iC, 1);
                                    _gameObjectRemovedSignal.dispatch(obstacleGO);
                                }
                            }
                        }
                    }
                }
            }
            //endregion

            //region UPDATE PLAYER BULLETS
            bulletLoop: for (i = _playerBullets.length - 1; i >= 0; i--)
            {
                playerBulletGO = _playerBullets[i];
                playerBulletGO.update(aDeltaTime);

                //if bullet is in game area
                if (_gameBounds.contains(playerBulletGO.transform.x, playerBulletGO.transform.y))
                {
                    //enemy collisions
                    for (iC = _enemies.length - 1; iC >= 0; iC--)
                    {
                        enemyGO = _enemies[iC];
                        removeBullet = false;
                        if (playerBulletGO.collider.checkCollision(enemyGO.collider))
                        {
                            if (playerBulletGO.bulletVO.mode == BulletMode.AOE)
                            {
                                _playerAoeBullets.push(playerBulletGO);
                                _aoeDamageTriggeredSignal.dispatch(playerBulletGO);
                                removeBullet = true;
                            }
                            else
                            {
                                //mark coliision for once colliders
                                if (playerBulletGO.collider is IOnceColliderComponent)
                                    IOnceColliderComponent(playerBulletGO.collider).markAsHit(enemyGO.collider);

                                //decrease hp
                                enemyGO.healthComponent.hit(playerBulletGO.bulletVO.damage);
                                removeBullet = playerBulletGO.bulletVO.mode == BulletMode.ONE_SHOT;

                                _gameObjectHitSignal.dispatch(enemyGO, 0);

                                //remove enemy if dead
                                if (enemyGO.healthComponent.hp <= 0)
                                {
                                    _enemies.splice(iC, 1);
                                    _gameObjectRemovedSignal.dispatch(enemyGO);
                                    _players[playerBulletGO.ownerID].score += enemyGO.enemyVO.initialHP * ENEMY_HP_TO_SCORE_RATIO;
                                }
                            }

                            //remove bullet & stop checking rest of enemies vector
                            if (removeBullet)
                            {
                                _playerBullets.splice(i, 1);
                                _gameObjectRemovedSignal.dispatch(playerBulletGO);
                                continue bulletLoop;
                            }
                        }
                    }

                    //obstacle collisions
                    for (iC = _obstacles.length - 1; iC >= 0; iC--)
                    {
                        obstacleGO = _obstacles[iC];
                        removeBullet = false;

                        if (playerBulletGO.collider.checkCollision(obstacleGO.collider))
                        {
                            if (playerBulletGO.bulletVO.mode == BulletMode.AOE)
                            {
                                _playerAoeBullets.push(playerBulletGO);
                                _aoeDamageTriggeredSignal.dispatch(playerBulletGO);
                                removeBullet = true;
                            }
                            else
                            {
                                //mark coliision for once colliders
                                if (playerBulletGO.collider is IOnceColliderComponent)
                                    IOnceColliderComponent(playerBulletGO.collider).markAsHit(obstacleGO.collider);

                                //decrease hp
                                obstacleGO.healthComponent.hit(playerBulletGO.bulletVO.damage);
                                removeBullet = playerBulletGO.bulletVO.mode == BulletMode.ONE_SHOT;

                                _gameObjectHitSignal.dispatch(obstacleGO, 0);

                                //remove obstacle if dead
                                if (obstacleGO.healthComponent.hp <= 0)
                                {
                                    _obstacles.splice(iC, 1);
                                    _gameObjectRemovedSignal.dispatch(obstacleGO);
                                    _players[playerBulletGO.ownerID].score += obstacleGO.obstacleVO.initialHP * OBSTACLE_HP_TO_SCORE_RATIO;
                                }
                            }

                            //remove bullet & stop checking rest of obstacles vector
                            if (removeBullet)
                            {
                                _playerBullets.splice(i, 1);
                                _gameObjectRemovedSignal.dispatch(playerBulletGO);
                                continue bulletLoop;
                            }
                        }
                    }
                }
                else
                {
                    //remove bullet
                    _playerBullets.splice(i, 1);
                    _gameObjectRemovedSignal.dispatch(playerBulletGO);
                }
            }

            //endregion

            //region UPDATE PLAYER AOE
            for (i = _playerAoeBullets.length - 1; i >= 0; i--)
            {
                playerBulletGO = _playerAoeBullets[i];
                playerBulletGO.update(aDeltaTime);

                //enemy collisions
                for (iC = _enemies.length - 1; iC >= 0; iC--)
                {
                    enemyGO = _enemies[iC];

                    //TODO: add circle collider for aoe
                    if (Math.pow(playerBulletGO.transform.x - enemyGO.transform.x, 2) + Math.pow(playerBulletGO.transform.y - enemyGO.transform.y, 2) < Math.pow(playerBulletGO.bulletVO.aoeDistance, 2))
                    {
                        //decrease hp
                        enemyGO.healthComponent.hit(playerBulletGO.bulletVO.damage);
                        _gameObjectHitSignal.dispatch(enemyGO, 0);

                        //remove enemy if dead
                        if (enemyGO.healthComponent.hp <= 0)
                        {
                            _enemies.splice(iC, 1);
                            _gameObjectRemovedSignal.dispatch(enemyGO);
                            _players[playerBulletGO.ownerID].score += enemyGO.enemyVO.initialHP * ENEMY_HP_TO_SCORE_RATIO;
                        }


                    }
                }

                //obstacle collisions
                for (iC = _obstacles.length - 1; iC >= 0; iC--)
                {
                    obstacleGO = _obstacles[iC];

                    //TODO: add circle collider for aoe
                    if (Math.pow(playerBulletGO.transform.x - obstacleGO.transform.x, 2) + Math.pow(playerBulletGO.transform.y - obstacleGO.transform.y, 2) < Math.pow(playerBulletGO.bulletVO.aoeDistance, 2))
                    {
                        //decrease hp
                        obstacleGO.healthComponent.hit(playerBulletGO.bulletVO.damage);
                        _gameObjectHitSignal.dispatch(obstacleGO, 0);

                        //remove obstacle if dead
                        if (obstacleGO.healthComponent.hp <= 0)
                        {
                            _obstacles.splice(iC, 1);
                            _gameObjectRemovedSignal.dispatch(obstacleGO);
                            _players[playerBulletGO.ownerID].score += obstacleGO.obstacleVO.initialHP * OBSTACLE_HP_TO_SCORE_RATIO;
                        }
                    }
                }

                //remove aoe bullet
                _playerAoeBullets.splice(i, 1);
                //todo aoe is removing itself from stage, introduce removedSignal for gameobjects instead
                //e.g.: playerBulletGO.removedSignal.add(some method wich will remove aoe GO and dispatch _gameObjectRemovedSignal)
                //_gameObjectRemovedSignal.dispatch(playerBulletGO);

            }

            //endregion

            //region UPDATE ENEMIES
            for (i = _enemies.length - 1; i >= 0; i--)
            {
                enemyGO = _enemies[i];

                if (_gameBounds.contains(_enemies[i].transform.x, _enemies[i].transform.y))
                {
                    enemyGO.update(aDeltaTime);
                }
                else
                {
                    _enemies.splice(i, 1);
                    _gameObjectRemovedSignal.dispatch(enemyGO);
                }
            }
            //endregion

            //region UPDATE ENEMY BULLETS
            for (i = _enemyBullets.length - 1; i >= 0; i--)
            {
                enemyBulletGO = _enemyBullets[i];

                //if bullet is in game area remove bullet
                if (_gameBounds.contains(enemyBulletGO.transform.x, enemyBulletGO.transform.y))
                {
                    enemyBulletGO.update(aDeltaTime);
                }
                else
                {
                    _enemyBullets.splice(i, 1);
                    _gameObjectRemovedSignal.dispatch(enemyBulletGO);
                }
            }
            //endregion

            //region UPDATE BONUSES
            for (i = _bonuses.length - 1; i >= 0; i--)
            {
                bonusGO = _bonuses[i];

                if (_gameBounds.contains(bonusGO.transform.x, bonusGO.transform.y))
                {
                    bonusGO.update(aDeltaTime);
                }
                else
                {
                    _bonuses.splice(i, 1);
                    _gameObjectRemovedSignal.dispatch(bonusGO);
                }
            }
            //endregion

            //region UPDATE OBSTACLES
            for (i = _obstacles.length - 1; i >= 0; i--)
            {
                obstacleGO = _obstacles[i];

                if (_gameBounds.contains(obstacleGO.transform.x, obstacleGO.transform.y))
                {
                    obstacleGO.update(aDeltaTime);
                }
                else
                {
                    _obstacles.splice(i, 1);
                    _gameObjectRemovedSignal.dispatch(obstacleGO);
                }
            }
            //endregion

        }

        private function levelEventHandler(aLevelEvent: LevelEvent): void
        {
            switch (aLevelEvent.id)
            {
                case LevelEvent.ID_SPAWN_ENEMY:
                    var enemyEvent: SpawnEnemyEvent = SpawnEnemyEvent(aLevelEvent);
                    var enemyVO: EnemyVO = enemyEvent.aEnemyVO;
                    var enemy: EnemyGO = new EnemyGO(enemyVO, enemyEvent.behaviorVO, this, enemyEvent.x, enemyEvent.y, getTarget(TargetType.PLAYER));
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

                case LevelEvent.ID_WAIT_FOR_CLEAR:
                    _state = STATE_WAIT_FOR_CLEAR;
                    break;

                case LevelEvent.ID_END:
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

            var weaponControl: WeaponControlComponent = _playerWeapons[aPlayerID];

            switch (aActionID)
            {
                case PlayerActionID.PRIMARY_FIRE:
                    aValue ? weaponControl.startShoot() : weaponControl.endShoot();
                    break;
            }
        }

        private function actionTriggerHandler(aPlayerID: uint, aActionID: uint): void
        {
            aPlayerID = Math.min(aPlayerID, _numPLayers - 1);

            var weaponControl: WeaponControlComponent = _playerWeapons[aPlayerID];

            switch (aActionID)
            {
                case PlayerActionID.PRIMARY_FIRE:
                    weaponControl.isShooting ? weaponControl.endShoot() : weaponControl.startShoot();
                    break;

                case PlayerActionID.CHARGE_FIRE:
                    weaponControl.chargeShoot();
                    break;

                case PlayerActionID.POWER_UP:
                    getBonus(aPlayerID, BonusTypeID.BONUS_WEAPON);
                    break;
                case PlayerActionID.POWER_DOWN:
                    weaponControl.weaponsOnDeath();
                    break;
                case PlayerActionID.WEAPON_LASER:
                    weaponControl.switchMainWeapon(weaponDef.getMainWeaponModel(PlayerWeaponID.LASER));
                    break;
                case PlayerActionID.WEAPON_PLASMA:
                    weaponControl.switchMainWeapon(weaponDef.getMainWeaponModel(PlayerWeaponID.PLASMA));
                    break;
                case PlayerActionID.WEAPON_ELECTRIC:
                    weaponControl.switchMainWeapon(weaponDef.getMainWeaponModel(PlayerWeaponID.ELECTRIC));
                    break;
            }
        }

        private function playerHealthHandler(aHealthComponent: IHealthComponent): void
        {
            if (aHealthComponent.state == HealthState.DEAD)
            {
                if (_players.length > 1)
                {
                    //check all players
                    for (var i: int = 0; i < _players.length; i++)
                    {
                        if (_players[i].state != HealthState.DEAD)
                            return;
                    }
                }

                TweenLite.delayedCall(1.5, endGame, [false]);
            }
        }

        private function getBonus(aPlayerID: uint, typeID: uint): void
        {
            switch (typeID)
            {
                case BonusTypeID.BONUS_HEALTH:
                    _playerHealth[aPlayerID].addHitPoints(80);
                    break;
                case BonusTypeID.BONUS_LIFE:
                    _playerHealth[aPlayerID].lives++;
                    break;
                case BonusTypeID.BONUS_WEAPON:
                    _playerWeapons[aPlayerID].weaponsAddPower();
                    break;
            }
        }

        //endregion
    }
}
