package game.model
{
    import game.model.gameObject.constants.BonusType;
    import game.model.gameObject.constants.EnemyType;
    import game.model.gameObject.constants.ObstacleType;
    import game.model.gameObject.def.IEnemyDefs;
    import game.model.gameObject.def.IObstacleDefs;
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

        private static const MAX_HP_PER_ROW: int = 400;

        private static const LEVEL_END_ERROR: String = "Adding events after level end not possible!";
        private static const LEVEL_NO_END_ERROR: String = "Level has no end!";

        [Inject]
        public var viewModel: IViewModel;

        [Inject]
        public var enemyDefs: IEnemyDefs;

        [Inject]
        public var obstacleDefs: IObstacleDefs;

        //rand helper vars
        private var randomDistIncrements: Vector.<int>;
        private var randomEnemyCount: Vector.<uint>;
        private var randomEnemyID: Vector.<uint>;
        private var randomBonusID: Vector.<uint>;
        private var randomObstacleID: Vector.<uint>;

        private var _levelEvents: Vector.<LevelEvent>;
        private var _currentDistance: uint = 0;
        private var _levelEnded: Boolean;

        /**
         * Generates LevelModel
         */
        public function SerialLevelGenerator()
        {
            initRadomValues();
        }

        public function getLevel(aDiffulcity: uint = 0): LevelModel
        {
            _levelEvents = new Vector.<LevelEvent>();
            _currentDistance = 0;
            _levelEnded = false;

            createLevel();

            addEnd();

            _levelEvents.sort(sortLevelEvents);

            if (!_levelEnded)
                throw new Error(LEVEL_NO_END_ERROR);

            return new LevelModel(_levelEvents);
        }

        private function createLevel(): void
        {
            addBonus();
            addBonus();
            addBonus();
            addBonus();
            addBonus();
            addDelay(3000);


            addBonus();
            addBonus();
            addBonus();
            addBonus();
            addFightersRow(100);
            addFightersRow(100);
            addFightersRow(100);
            addFightersRow(150);
            addFightersRow(150);
            addFightersRow(150);
            addFightersRow(200);
            addFightersRow(200);
            addDelay(5000);

            addBonus();
            addBonus();
            addBonus();
            addBonus();
            addMeteorsRain(3000);
            addWAitForClear();

            addBonus();
            addBonus();
            addBonus();
            addBonus();
            addFightersRow(250);
            addFightersRow(250);
            addFightersRow(300);
            addFightersRow(400);
            addFightersRow(500);
            addWAitForClear();

            addFightersRows(1000);
            addWAitForClear();

            addBonus();
            addBonus();
            addBonus();
            addBonus();
            addFightersRows(1200);
            addWAitForClear();

            addBonus();
            addBonus();
            addBonus();
            addBonus();
            addFightersRows(1500);
            addWAitForClear();
            addMeteorsRain(6000);

            addBonus();
            addBonus();
            addBonus();
            addBonus();
            addFightersRows(2000);
            addWAitForClear();

            addBonus();
            addBonus();
            addBonus();
            addBonus();
            addFightersRows(2000);
            addWAitForClear();


            //add random bonuses - start, end, count
            //add random meteors - start, end, total hp

            //addBoss
        }

        private function addFightersRow(aTotalHP: int = 300, aFighterType: int = RANDOM, aDelayAfter: int = 1000): void
        {
            if (_levelEnded)
                throw new Error(LEVEL_END_ERROR);

            if (aFighterType == RANDOM)
                aFighterType = getRandFighterID();

            var enemyVO: EnemyVO = enemyDefs.getEnemyVO(aFighterType);
            var aCount: int = Math.floor(aTotalHP / enemyVO.initialHP);
            var xGap: Number;
            var x: Number;

            for (var i: int = 0; i < aCount; i++)
            {
                xGap = (viewModel.gameWidth - 2 * viewModel.spawnBounds) / aCount;
                x = viewModel.spawnBounds + xGap / 2 + i * xGap;
                _levelEvents.push(new SpawnEnemyEvent(_currentDistance, enemyVO, x, -GameModel.OUTER_BOUNDS));
            }

            addDelay(aDelayAfter);
        }

        private function addFightersRows(aTotalHP: int = 1000, aFighterType: int = RANDOM, aRowCount: int = RANDOM, aRowDistance: int = RANDOM, aDelayAfter: int = 1000): void
        {
            if (_levelEnded)
                throw new Error(LEVEL_END_ERROR);

            if (aFighterType == RANDOM)
                aFighterType = getRandFighterID();

            if (aRowCount == RANDOM)
            {
                aRowCount = getRandInt(2, 5);

                if (aTotalHP / aRowCount > MAX_HP_PER_ROW)
                    aRowCount = Math.ceil(aTotalHP / MAX_HP_PER_ROW)

            }

            aTotalHP = Math.floor(aTotalHP / aRowCount);

            for (var i: int = 0; i < aRowCount; i++)
            {
                addFightersRow(aTotalHP, aFighterType, 600);
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
            addDelay(1000);
            _levelEvents.push(new LevelEvent(LevelEvent.ID_WAIT_FOR_CLEAR, _currentDistance + LevelModel.SPEED));
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
            randomEnemyID = new Vector.<uint>();
            randomEnemyID.push(EnemyType.FIGHTER_1);
            randomEnemyID.push(EnemyType.FIGHTER_2);
            randomEnemyID.push(EnemyType.FIGHTER_3);
            randomEnemyID.push(EnemyType.FIGHTER_4);

            //bonus type ID
            randomBonusID = new Vector.<uint>();
            randomBonusID.push(BonusType.BONUS_LIFE);
            randomBonusID.push(BonusType.BONUS_WEAPON);
            randomBonusID.push(BonusType.BONUS_WEAPON);
            randomBonusID.push(BonusType.BONUS_HEALTH);
            randomBonusID.push(BonusType.BONUS_HEALTH);

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
            return randomEnemyID[int(Math.random() * (randomEnemyID.length - 1))];
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
            return -0.05 + Math.random() * 0.10;
        }

        private static function getRandSpeedY(): Number
        {
            return 0.1 + Math.random() * 0.15;
        }

        private static function getRandSpeedRotation(): Number
        {
            return -0.1 + Math.random() * 0.2;
        }

        //endregion
    }
}
