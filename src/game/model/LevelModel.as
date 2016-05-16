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

    import org.osflash.signals.Signal;
    import org.robotlegs.mvcs.Actor;

    public final class LevelModel extends Actor implements ILevelModel
    {
        public static const SPAWN_BOUNDS: Number = 100;

        [Inject]
        public var viewModel: IViewModel;

        [Inject]
        public var enemyDefs: IEnemyDefs;

        [Inject]
        public var obstacleDefs: IObstacleDefs;

        // fly thru level speed: m / s;
        public static const SPEED: uint = 200;

        private var _levelLength: Number = 20000;
        private var _distance: Number = 0;

        private var _levelEvents: Vector.<LevelEvent>;
        private var _levelEventSignal: Signal;

        //rand helper vars
        private var randomDistIncrements: Vector.<int>;
        private var randomEnemyCount: Vector.<uint>;
        private var randomEnemyID: Vector.<uint>;
        private var randomBonusID: Vector.<uint>;
        private var randomObstacleID: Vector.<uint>;


        /**
         * Model storing level events
         * now its also generating event it self i.e. its a very simple random level genarator
         * generating events itself should be replaced by more sophisticated solution in separate class,
         * or just parser of data which could be created in level editor
         */
        public function LevelModel()
        {
            _levelEventSignal = new Signal(LevelEvent);
            _levelEvents = new Vector.<LevelEvent>();
        }

        public function get levelEventSignal(): Signal
        {
            return _levelEventSignal;
        }

        public function init(): void
        {
            var i: int;

            initRadomValues();

            //GENERATE ENEMIES
            for (i = 0; i < 20; i++)
            {
                generateFightersRow(_levelLength / 20 * i, geRandCount(), geRandIncrement());
            }

            //GENERATE BONUSES
            for (i = 0; i < 30; i++)
            {
                _levelEvents.push(new SpawnBonusEvent(i * _levelLength / 30, new BonusVO(getRandBonusID(), 10, 10), getRandX(), -GameModel.OUTER_BOUNDS));
            }

            //GENERATE OBSTACLES
            for (i = 0; i < 40; i++)
            {
                var obstacleVO: ObstacleVO = obstacleDefs.getObstacleVO(getRandObstacleID());
                var distance: Number = (40 + i) * _levelLength / 80;
                _levelEvents.push(new SpawnObstacleEvent(distance, obstacleVO, getRandX(), -GameModel.OUTER_BOUNDS, getRandSpeedX(), getRandSpeedY(), getRandSpeedRotation()));
            }

            _levelEvents.push(new LevelEvent(LevelEvent.ID_END, _levelLength + 500));
            _levelEvents.sort(sortLevelEvents);
        }


        public function progress(aDeltaTime: int): void
        {
            _distance += SPEED * aDeltaTime / 1000;

            var levelEvent: LevelEvent;
            while (_levelEvents.length > 0 && _levelEvents[0].distance < _distance)
            {
                levelEvent = _levelEvents.shift();
                _levelEventSignal.dispatch(levelEvent);
            }

        }

        private function generateFightersRow(aStartDist: Number, aCount: uint, aDistIncrement: Number = 0): void
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
                _levelEvents.push(new SpawnEnemyEvent(distance, enemyVO, x, y));
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
