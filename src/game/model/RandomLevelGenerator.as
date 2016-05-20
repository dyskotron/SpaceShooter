package game.model
{
    import game.model.gameObject.constants.BonusType;
    import game.model.gameObject.constants.EnemyType;
    import game.model.gameObject.constants.ObstacleType;
    import game.model.gameObject.def.IEnemyDefs;
    import game.model.gameObject.def.IObstacleDefs;
    import game.model.gameObject.enemy.ITarget;
    import game.model.gameObject.enemy.Target;
    import game.model.gameObject.vo.BonusVO;
    import game.model.gameObject.vo.EnemyVO;
    import game.model.gameObject.vo.ObstacleVO;
    import game.model.levelModel.LevelEvent;
    import game.model.levelModel.SpawnBonusEvent;
    import game.model.levelModel.SpawnEnemyEvent;
    import game.model.levelModel.SpawnObstacleEvent;

    import main.model.IViewModel;

    import org.robotlegs.mvcs.Actor;

    public class RandomLevelGenerator extends Actor implements ILevelProvider
    {
        public static const SPAWN_BOUNDS: Number = 100;

        [Inject]
        public var viewModel: IViewModel;

        [Inject]
        public var enemyDefs: IEnemyDefs;

        [Inject]
        public var obstacleDefs: IObstacleDefs;

        private var _levelLength: Number = 20000;

        //rand helper vars
        private var randomDistIncrements: Vector.<int>;
        private var randomEnemyCount: Vector.<uint>;
        private var randomEnemyID: Vector.<uint>;
        private var randomBonusID: Vector.<uint>;
        private var randomObstacleID: Vector.<uint>;

        private var screenCenter: ITarget;

        /**
         * Generates LevelModel
         */
        public function RandomLevelGenerator()
        {
            initRadomValues();
            screenCenter = new Target(viewModel.stageWidth / 2, viewModel.stageHeight / 2);
        }

        public function getLevel(aDiffulcity: uint = 0): LevelModel
        {
            var i: int;
            var levelEvents: Vector.<LevelEvent> = new Vector.<LevelEvent>();

            for (i = 0; i < 4; i++)
            {
                generateMeteorsRain(levelEvents, i * _levelLength / 4 + LevelModel.SPEED * 3, 5000);
            }

            //GENERATE ENEMIES
            var rowCount: uint = 20;
            for (i = 0; i < rowCount; i++)
            {
                if (i == 0 || i % (rowCount / groupCount) != 0)
                    generateFightersRow(levelEvents, _levelLength / rowCount * i, geRandCount(), geRandIncrement());
            }

            var groupCount: uint = 5;
            for (i = 1; i < groupCount; i++)
            {
                generateFightersGroup(levelEvents, _levelLength / groupCount * i, geRandCount(), geRandInt(2, 5));
            }

            //GENERATE METEORS
            for (i = 0; i < 40; i++)
            {
                var obstacleVO: ObstacleVO = obstacleDefs.getObstacleVO(getRandObstacleID());
                var distance: Number = (40 + i) * _levelLength / 80;
                levelEvents.push(new SpawnObstacleEvent(distance, obstacleVO, getRandX(), -GameModel.OUTER_BOUNDS, getRandSpeedX(), getRandSpeedY(), getRandSpeedRotation()));
            }


            //GENERATE BONUSES
            for (i = 0; i < 30; i++)
            {
                levelEvents.push(new SpawnBonusEvent(i * _levelLength / 30, new BonusVO(getRandBonusID(), 30, 30), getRandX(), -GameModel.OUTER_BOUNDS));
            }

            levelEvents.push(new LevelEvent(LevelEvent.ID_END, _levelLength + 500));
            levelEvents.sort(sortLevelEvents);

            return new LevelModel(levelEvents);
        }

        private function generateFightersRow(aLevelEvents: Vector.<LevelEvent>, aStartDist: Number, aCount: uint, aDistIncrement: Number = 0): void
        {
            var aEnemyTypeID: uint;

            if (aCount > 10)
                aEnemyTypeID = EnemyType.FIGHTER_1;
            else if (aCount > 5)
                aEnemyTypeID = EnemyType.FIGHTER_2;
            else if (aCount > 2)
                aEnemyTypeID = EnemyType.FIGHTER_3;
            else
                aEnemyTypeID = EnemyType.FIGHTER_4;

            var enemyVO: EnemyVO = enemyDefs.getEnemyVO(aEnemyTypeID);
            var distance: Number;
            var xGap: Number;
            var x: Number;
            var y: Number;

            for (var i: int = 0; i < aCount; i++)
            {
                distance = aStartDist + i * aDistIncrement;
                xGap = (viewModel.gameWidth - 2 * SPAWN_BOUNDS) / aCount;
                x = SPAWN_BOUNDS + xGap / 2 + i * xGap;
                y = -GameModel.OUTER_BOUNDS;
                aLevelEvents.push(new SpawnEnemyEvent(enemyVO, screenCenter, distance, x, y));
            }
        }

        private function generateFightersGroup(aLevelEvents: Vector.<LevelEvent>, aStartDist: Number, aCount: uint, aRowsCount: uint): void
        {
            var aEnemyTypeID: uint;

            if (aCount > 10)
                aEnemyTypeID = EnemyType.FIGHTER_1;
            else if (aCount > 5)
                aEnemyTypeID = EnemyType.FIGHTER_2;
            else if (aCount > 2)
                aEnemyTypeID = EnemyType.FIGHTER_3;
            else
                aEnemyTypeID = EnemyType.FIGHTER_4;

            var enemyVO: EnemyVO = enemyDefs.getEnemyVO(aEnemyTypeID);
            var distance: Number;
            var xGap: Number;
            var x: Number;
            var y: Number;

            for (var iRow: int = 0; iRow < aRowsCount; iRow++)
            {
                for (var i: int = 0; i < aCount; i++)
                {
                    distance = aStartDist;
                    xGap = (viewModel.gameWidth - 2 * SPAWN_BOUNDS) / aCount;
                    x = SPAWN_BOUNDS + xGap / 2 + i * xGap;
                    y = -GameModel.OUTER_BOUNDS;
                    aLevelEvents.push(new SpawnEnemyEvent(enemyVO, screenCenter, distance + LevelModel.SPEED / 3 * iRow, x, y));
                }
            }
        }

        private function generateMeteorsRain(aLevelEvents: Vector.<LevelEvent>, aStartDist: Number, aTotalHP: int): void
        {
            var i: int = 0;
            while (aTotalHP > 0)
            {
                var obstacleVO: ObstacleVO = obstacleDefs.getObstacleVO(getRandObstacleID());
                aLevelEvents.push(new SpawnObstacleEvent(aStartDist + i * 10, obstacleVO, getRandX(), -GameModel.OUTER_BOUNDS, getRandSpeedX(), getRandSpeedY(), getRandSpeedRotation()));
                aTotalHP -= obstacleVO.initialHP;
                i++
            }
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
            randomDistIncrements.push(-10);
            randomDistIncrements.push(20);
            randomDistIncrements.push(-20);
            randomDistIncrements.push(40);
            randomDistIncrements.push(-40);

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

        private function geRandInt(aMin: int, aMax: int): int
        {
            return Math.round(aMin + Math.random() * (aMax - aMin));
        }

        private function getRandEnemyID(): int
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
            return SPAWN_BOUNDS + Math.random() * (viewModel.gameWidth - 2 * SPAWN_BOUNDS);
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
