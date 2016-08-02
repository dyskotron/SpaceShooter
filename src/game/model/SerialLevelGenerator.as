package game.model
{
    import game.model.gameObject.component.fsm.Target;
    import game.model.gameObject.constants.BonusTypeID;
    import game.model.gameObject.constants.EnemyType;
    import game.model.gameObject.constants.ObstacleType;
    import game.model.gameObject.def.BehaviorFactory;
    import game.model.gameObject.def.IBehaviorFactory;
    import game.model.gameObject.def.IEnemyDefs;
    import game.model.gameObject.def.IObstacleDefs;
    import game.model.gameObject.vo.BehaviorVO;
    import game.model.gameObject.vo.BonusVO;
    import game.model.gameObject.vo.EnemyVO;
    import game.model.gameObject.vo.ObstacleVO;
    import game.model.levelModel.LevelEvent;
    import game.model.levelModel.SpawnBonusEvent;
    import game.model.levelModel.SpawnEnemyEvent;
    import game.model.levelModel.SpawnObstacleEvent;

    import main.model.IViewModel;

    import org.robotlegs.mvcs.Actor;

    public class SerialLevelGenerator extends Actor implements ILevelProvider
    {
        private static const RANDOM: int = -1;
        private static const RANDOM_EACH: int = -2;

        private static const MAX_HP_PER_ROW: int = 400;

        private static const LEVEL_END_ERROR: String = "Adding events after level end not possible!";
        private static const LEVEL_NO_END_ERROR: String = "Level has no end!";

        [Inject]
        public var viewModel: IViewModel;

        [Inject]
        public var behaviorDefs: IBehaviorFactory;

        [Inject]
        public var enemyDefs: IEnemyDefs;

        [Inject]
        public var obstacleDefs: IObstacleDefs;

        //rand helper vars
        private var randomDistIncrements: Vector.<int>;
        private var randomEnemyCount: Vector.<uint>;
        private var randomFighterID: Vector.<uint>;
        private var randomKamikazeID: Vector.<uint>;
        private var randomWobblerID: Vector.<uint>;
        private var randomBonusID: Vector.<uint>;
        private var randomObstacleID: Vector.<uint>;

        private var _levelEvents: Vector.<LevelEvent>;
        private var _currentDistance: uint = 0;
        private var _levelEnded: Boolean;
        private var screenCenter: Target;

        /**
         * Generates LevelModel
         */
        public function SerialLevelGenerator()
        {
            initRadomValues();
        }

        public function getLevel(aDiffulcity: uint = 0): ILevelModel
        {
            _levelEvents = new Vector.<LevelEvent>();
            _currentDistance = 0;
            _levelEnded = false;

            createLevel();

            addEnd();

            _levelEvents.sort(sortLevelEvents);

            if (!_levelEnded)
                throw new Error(LEVEL_NO_END_ERROR);

            return new LoopedLevelModel(_levelEvents);
            //return new LevelModel(_levelEvents);
        }

        private function createLevel(): void
        {
            screenCenter = new Target(viewModel.stageWidth / 2, viewModel.stageHeight / 2);
            if (false)
            {
                //addFightersRow(80, EnemyType.FIGHTER_1, (viewModel.gameHeight * 0.8), 500);
                addDelay(1000);
                addMeteorsRain(6000);

                addWAitForClear();

                return;
            }

            addBonus(0);
            addBonus(0);
            addBonus(0);
            addBonus(0);
            addBonus(0);
            addBonus(0);
            addBonus(0);
            //addDelay(3000);
            /*
             var tempDistance: uint = _currentDistance;
             addWobbleGroup(EnemyType.WOBBLY_1, 15, viewModel.gameWidth / 15 * 11);
             _currentDistance = tempDistance;
             addWobbleGroup(EnemyType.WOBBLY_3, 15, viewModel.gameWidth / 2);
             _currentDistance = tempDistance;
             addWobbleGroup(EnemyType.WOBBLY_2, 15, viewModel.gameWidth / 15 * 4);

             return;
             */

            addFightersRows(600, RANDOM_EACH, RANDOM, 1200);
            addWAitForClear();

            addWobbleGroup(EnemyType.WOBBLY_1, 15, viewModel.gameWidth / 15 * 11);
            addWobbleGroup(EnemyType.WOBBLY_1, 15, viewModel.gameWidth / 15 * 4);
            addWAitForClear();

            addKamikazeGroup(EnemyType.KAMIKAZE_1, 2, viewModel.gameWidth / 15 * 14, -viewModel.gameWidth / 20, viewModel.gameHeight / 5);
            addKamikazeGroup(EnemyType.KAMIKAZE_1, 2, viewModel.gameWidth / 15, viewModel.gameWidth / 20, viewModel.gameHeight / 5);

            addBonus();
            addBonus();
            addBonus();
            addBonus();
            addBonus();
            addBonus();
            addBonus();
            addBonus();
            addBonus();
            addBonus();
            addFightersRows(1200, RANDOM_EACH, RANDOM, 1200);
            addWAitForClear();

            addKamikazeGroup(EnemyType.KAMIKAZE_1, 4, viewModel.gameWidth / 15 * 14, -viewModel.gameWidth / 20, viewModel.gameHeight / 4);
            addKamikazeGroup(EnemyType.KAMIKAZE_1, 4, viewModel.gameWidth / 15, viewModel.gameWidth / 20, viewModel.gameHeight / 4);

            addFightersRows(1400, RANDOM_EACH, RANDOM, 1200);
            addWAitForClear();

            addBonus();
            addBonus();
            addBonus();
            addBonus();
            addBonus();
            addBonus();
            addMeteorsRain(3000);
            addWAitForClear();

            addWobbleGroup(EnemyType.WOBBLY_1, 15, viewModel.gameWidth / 15 * 11);
            addWobbleGroup(EnemyType.WOBBLY_1, 15, viewModel.gameWidth / 15 * 4);
            addWAitForClear();

            addBonus();
            addBonus();
            addBonus();
            addBonus();
            addBonus();
            addBonus();
            addFightersRows(1600, RANDOM, RANDOM, 1200);
            addWAitForClear();

            addFightersRows(1800);
            addKamikazeGroup(EnemyType.KAMIKAZE_1, 4, viewModel.gameWidth / 15 * 14, -viewModel.gameWidth / 20, viewModel.gameHeight / 3);
            addKamikazeGroup(EnemyType.KAMIKAZE_1, 4, viewModel.gameWidth / 15, viewModel.gameWidth / 20, viewModel.gameHeight / 3);
            addWAitForClear();

            addBonus();
            addBonus();
            addBonus();
            addBonus();
            addBonus();
            addFightersRows(2000);
            addWAitForClear();

            addWobbleGroup(EnemyType.WOBBLY_2, 15, viewModel.gameWidth / 15 * 11);
            addWobbleGroup(EnemyType.WOBBLY_2, 15, viewModel.gameWidth / 15 * 4);
            addWAitForClear();

            addBonus();
            addBonus();
            addBonus();
            addBonus();
            addBonus();
            addFightersRows(2200);
            addWAitForClear();
            addMeteorsRain(6000);
            addWAitForClear();

            addKamikazeGroup(EnemyType.KAMIKAZE_2, 3, viewModel.gameWidth / 15, viewModel.gameWidth / 15, viewModel.gameHeight / 2);
            addKamikazeGroup(EnemyType.KAMIKAZE_2, 3, viewModel.gameWidth / 15 * 14, -viewModel.gameWidth / 15, viewModel.gameHeight / 2);

            addBonus();
            addBonus();
            addBonus();
            addBonus();
            addBonus();
            addBonus();
            addFightersRows(2000);
            addWobbleGroup(EnemyType.WOBBLY_2, 15, viewModel.gameWidth / 15 * 11);
            addWobbleGroup(EnemyType.WOBBLY_2, 15, viewModel.gameWidth / 15 * 4);
            addKamikazeGroup(EnemyType.KAMIKAZE_2, 3, viewModel.gameWidth / 15, viewModel.gameWidth / 15, viewModel.gameHeight / 3 * 2);
            addKamikazeGroup(EnemyType.KAMIKAZE_2, 3, viewModel.gameWidth / 15 * 14, -viewModel.gameWidth / 15, viewModel.gameHeight / 3 * 2);
            addWAitForClear();

            addBonus();
            addBonus();
            addBonus();
            addBonus();
            addBonus();
            addBonus();
            addFightersRows(2500);
            addWAitForClear();


            addFightersRows(2500);
            addWobbleGroup(EnemyType.WOBBLY_1, 15, viewModel.gameWidth / 15 * 9);
            addWobbleGroup(EnemyType.WOBBLY_1, 15, viewModel.gameWidth / 15 * 6);
            addWobbleGroup(EnemyType.WOBBLY_2, 15, viewModel.gameWidth / 15 * 11);
            addWobbleGroup(EnemyType.WOBBLY_2, 15, viewModel.gameWidth / 15 * 4);
            addKamikazeGroup(EnemyType.KAMIKAZE_2, 3, viewModel.gameWidth / 15, viewModel.gameWidth / 15, viewModel.gameHeight / 3 * 2);
            addKamikazeGroup(EnemyType.KAMIKAZE_2, 3, viewModel.gameWidth / 15 * 14, -viewModel.gameWidth / 15, viewModel.gameHeight / 3 * 2);
            addWAitForClear();


            //add random bonuses - start, end, count
            //add random meteors - start, end, total hp

            //addBoss
        }


        private function addWobbleGroup(aWobbleType: int = RANDOM, aCount: uint = 1, aX: Number = 0, aDistanceX: Number = 0, aDelayAfter: int = 1000): void
        {
            for (var i: int = 0; i < aCount; i++)
            {
                addWobble(aWobbleType, aX + i * aDistanceX, 350);
            }

            addDelay(aDelayAfter);
        }

        private function addWobble(aWobbleType: int = RANDOM, aX: Number = 0, aDelayAfter: int = 1000): void
        {
            if (_levelEnded)
                throw new Error(LEVEL_END_ERROR);

            if (aWobbleType == RANDOM)
                aWobbleType = getRandWobblerID();

            if (aX == 0)
                aX = viewModel.gameWidth / 2;

            var enemyVO: EnemyVO = enemyDefs.getEnemyVO(aWobbleType);
            var behavior: BehaviorVO = behaviorDefs.getBehaviorVO(BehaviorFactory.WOBBLE);

            _levelEvents.push(new SpawnEnemyEvent(enemyVO, behavior, _currentDistance, aX, -GameModel.OUTER_BOUNDS));

            addDelay(aDelayAfter);
        }


        private function addKamikazeGroup(aKamikazeType: int = RANDOM, aCount: uint = 1, aX: Number = 0, aDistanceX: Number = 0, aDestinationY: int = 0, aDelayAfter: int = 1000): void
        {
            for (var i: int = 0; i < aCount; i++)
            {
                addKamikaze(aKamikazeType, aX + i * aDistanceX, aDestinationY, 100);
            }

            addDelay(aDelayAfter);
        }

        private function addKamikaze(aKamikazeType: int = RANDOM, aX: Number = 0, aDestinationY: int = 0, aDelayAfter: int = 1000): void
        {
            if (_levelEnded)
                throw new Error(LEVEL_END_ERROR);

            if (aKamikazeType == RANDOM)
                aKamikazeType = getRandKamikazeID();

            if (aX == 0)
                aX = viewModel.gameWidth / 2;

            var enemyVO: EnemyVO = enemyDefs.getEnemyVO(aKamikazeType);
            var behaviorID: uint = aKamikazeType == EnemyType.KAMIKAZE_1 ? BehaviorFactory.KAMIKAZE_STRAIGHT : BehaviorFactory.KAMIKAZE_CHASE;
            var behavior: BehaviorVO = behaviorDefs.getBehaviorVO(behaviorID, new Target(0, aDestinationY));

            _levelEvents.push(new SpawnEnemyEvent(enemyVO, behavior, _currentDistance, aX, -GameModel.OUTER_BOUNDS));

            addDelay(aDelayAfter);
        }

        private function addFighter(aFighterType: int = RANDOM, aX: Number = 0, aDestinationY: int = 0, aDelayAfter: int = 1000): void
        {
            if (_levelEnded)
                throw new Error(LEVEL_END_ERROR);

            if (aFighterType == RANDOM)
                aFighterType = getRandFighterID();

            if (aDestinationY == 0)
                aDestinationY = viewModel.gameHeight / 5 * 4;

            if (aX == 0)
                aX = viewModel.gameWidth / 2;

            var enemyVO: EnemyVO = enemyDefs.getEnemyVO(aFighterType);
            var behavior: BehaviorVO = behaviorDefs.getBehaviorVO(BehaviorFactory.GET_TO_Y, new Target(viewModel.gameWidth / 2, aDestinationY));

            _levelEvents.push(new SpawnEnemyEvent(enemyVO, behavior, _currentDistance, aX, -GameModel.OUTER_BOUNDS));

            addDelay(aDelayAfter);
        }

        private function addFightersRow(aTotalHP: int = 300, aFighterType: int = RANDOM, aDestinationY: int = 0, aDelayAfter: int = 1000): void
        {
            if (_levelEnded)
                throw new Error(LEVEL_END_ERROR);

            if (aFighterType == RANDOM)
                aFighterType = getRandFighterID();

            if (aDestinationY == 0)
                aDestinationY = viewModel.gameHeight / 5 * 4;

            var enemyVO: EnemyVO = enemyDefs.getEnemyVO(aFighterType);
            var aCount: int = Math.floor(aTotalHP / enemyVO.initialHP);
            var target: Target = new Target(viewModel.gameWidth / 2, aDestinationY);
            var behavior: BehaviorVO;
            var xGap: Number;
            var x: Number;

            for (var i: int = 0; i < aCount; i++)
            {
                behavior = behaviorDefs.getBehaviorVO(BehaviorFactory.GET_TO_Y, target);
                xGap = (viewModel.gameWidth - 2 * viewModel.spawnBounds) / aCount;
                x = viewModel.spawnBounds + xGap / 2 + i * xGap;
                _levelEvents.push(new SpawnEnemyEvent(enemyVO, behavior, _currentDistance, x, -GameModel.OUTER_BOUNDS));
            }

            addDelay(aDelayAfter);
        }

        private function addFightersRows(aTotalHP: int = 1000, aFighterType: int = RANDOM, aRowCount: int = RANDOM, aRowsDelay: int = 600, aDelayAfter: int = 1000): void
        {
            if (_levelEnded)
                throw new Error(LEVEL_END_ERROR);

            if (aFighterType == RANDOM)
                aFighterType = getRandFighterID();
            else if (aFighterType == RANDOM_EACH)
                aFighterType = RANDOM;

            if (aRowCount == RANDOM)
            {
                aRowCount = getRandInt(2, 5);

                if (aTotalHP / aRowCount > MAX_HP_PER_ROW)
                    aRowCount = Math.ceil(aTotalHP / MAX_HP_PER_ROW);
            }

            aTotalHP = Math.floor(aTotalHP / aRowCount);

            for (var i: int = 0; i < aRowCount; i++)
            {
                addFightersRow(aTotalHP, aFighterType, (viewModel.gameHeight * 0.8) / (aRowCount + 1) * (aRowCount - i), aRowsDelay);
            }

            addDelay(aDelayAfter);
        }

        private function addMeteorsRain(aTotalHP: int): void
        {
            if (aTotalHP == 0)
                return;

            if (_levelEnded)
                throw new Error(LEVEL_END_ERROR);

            while (aTotalHP > 0)
            {
                var obstacleVO: ObstacleVO = obstacleDefs.getObstacleVO(getRandObstacleID());

                _levelEvents.push(new SpawnObstacleEvent(_currentDistance, obstacleVO, getRandX(), -GameModel.OUTER_BOUNDS, getRandSpeedX(), getRandSpeedY(), getRandSpeedRotation()));
                _currentDistance += 10;
                aTotalHP -= obstacleVO.initialHP;
            }
        }

        private function addBonus(aDelayAfter: int = 500): void
        {
            if (_levelEnded)
                throw new Error(LEVEL_END_ERROR);

            _levelEvents.push(new SpawnBonusEvent(_currentDistance, new BonusVO(getRandBonusID(), 30, 30), getRandX(), -GameModel.OUTER_BOUNDS));

            addDelay(aDelayAfter);
        }

        private function addEnd(): void
        {
            addDelay(1000);
            _levelEvents.push(new LevelEvent(LevelEvent.ID_WAIT_FOR_CLEAR, _currentDistance + LevelModel.SPEED));
            addDelay(1000);
            _levelEvents.push(new LevelEvent(LevelEvent.ID_END, _currentDistance + LevelModel.SPEED));
            _levelEnded = true;
        }

        private function addDelay(aMiliseconds: uint): void
        {
            _currentDistance += aMiliseconds / 1000 * LevelModel.SPEED;
        }

        private function addWAitForClear(): void
        {
            addDelay(500);
            _levelEvents.push(new LevelEvent(LevelEvent.ID_WAIT_FOR_CLEAR, _currentDistance));
            addDelay(500);
        }

        private static function sortLevelEvents(alevelEventA: LevelEvent, aLevelEventB: LevelEvent): Number
        {
            return alevelEventA.distance - aLevelEventB.distance;
        }

        //region ---------------------------------- RANDOM GENERATION HELPERS ---------------------------------- //

        private function initRadomValues(): void
        {
            //dist
            randomDistIncrements = new Vector.<int>();
            randomDistIncrements.push(0);
            randomDistIncrements.push(10);
            randomDistIncrements.push(20);
            randomDistIncrements.push(40);

            //enemyCount
            randomEnemyCount = new Vector.<uint>();
            randomEnemyCount.push(2);
            randomEnemyCount.push(3);
            randomEnemyCount.push(5);
            randomEnemyCount.push(8);
            randomEnemyCount.push(10);
            randomEnemyCount.push(14);
            randomEnemyCount.push(18);

            //enemy type ID
            randomFighterID = new Vector.<uint>();
            randomFighterID.push(EnemyType.FIGHTER_1);
            randomFighterID.push(EnemyType.FIGHTER_2);
            randomFighterID.push(EnemyType.FIGHTER_3);
            randomFighterID.push(EnemyType.FIGHTER_4);

            //enemy type ID
            randomKamikazeID = new Vector.<uint>();
            randomKamikazeID.push(EnemyType.KAMIKAZE_1);
            randomKamikazeID.push(EnemyType.KAMIKAZE_2);

            //enemy type ID
            randomWobblerID = new Vector.<uint>();
            randomWobblerID.push(EnemyType.WOBBLY_1);
            randomWobblerID.push(EnemyType.WOBBLY_2);

            //bonus type ID
            randomBonusID = new Vector.<uint>();
            randomBonusID.push(BonusTypeID.BONUS_LIFE);
            randomBonusID.push(BonusTypeID.BONUS_WEAPON);
            randomBonusID.push(BonusTypeID.BONUS_WEAPON);
            randomBonusID.push(BonusTypeID.BONUS_HEALTH);
            randomBonusID.push(BonusTypeID.BONUS_HEALTH);

            //obstacle type ID
            randomObstacleID = new Vector.<uint>();
            randomObstacleID.push(ObstacleType.TINY_1);
            randomObstacleID.push(ObstacleType.TINY_2);
            randomObstacleID.push(ObstacleType.SMALL_1);
            randomObstacleID.push(ObstacleType.SMALL_2);
            randomObstacleID.push(ObstacleType.MEDIUM_1);
            randomObstacleID.push(ObstacleType.MEDIUM_2);
            randomObstacleID.push(ObstacleType.BIG_1);
            randomObstacleID.push(ObstacleType.BIG_2);
            //randomObstacleID.push(ObstacleType.BIG_3);
            //randomObstacleID.push(ObstacleType.BIG_4);
        }

        private function geRandIncrement(): int
        {
            return randomDistIncrements[int(Math.random() * (randomDistIncrements.length - 1))];
        }

        private function geRandCount(): int
        {
            return randomEnemyCount[int(Math.random() * (randomEnemyCount.length - 1))];
        }

        private function getRandInt(aMin: int, aMax: int): int
        {
            return Math.round(aMin + Math.random() * (aMax - aMin));
        }

        private function getRandFighterID(): int
        {
            return randomFighterID[int(Math.random() * (randomFighterID.length - 1))];
        }

        private function getRandKamikazeID(): int
        {
            return randomKamikazeID[int(Math.random() * (randomKamikazeID.length - 1))];
        }

        private function getRandWobblerID(): int
        {
            return randomWobblerID[int(Math.random() * (randomWobblerID.length - 1))];
        }

        private function getRandBonusID(): int
        {
            return randomBonusID[int(Math.random() * (randomBonusID.length - 1))];
        }

        private function getRandObstacleID(): int
        {
            return randomObstacleID[int(Math.random() * (randomObstacleID.length - 1))];
        }

        private function getRandX(): Number
        {
            return viewModel.spawnBounds + Math.random() * (viewModel.gameWidth - 2 * viewModel.spawnBounds);
        }

        private static function getRandSpeedX(): Number
        {
            return -80 + Math.random() * 160;
        }

        private static function getRandSpeedY(): Number
        {
            return 100 + Math.random() * 150;
        }

        private static function getRandSpeedRotation(): Number
        {
            return (-0.1 + Math.random() * 0.2) * Math.PI / 180;
        }

        //endregion
    }
}
