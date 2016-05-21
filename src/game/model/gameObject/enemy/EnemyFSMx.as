package game.model.gameObject.enemy
{
    import game.model.gameObject.EnemyGO;

    public class EnemyFSMx
    {
        public static const ACTION_NONE: uint = 0;
        public static const ACTION_PREV: uint = 1;
        public static const ACTION_NEXT: uint = 2;
        public static const ACTION_FIRST: uint = 3;
        public static const ACTION_LAST: uint = 4;


        private var _curentState: IEnemyState;
        private var _target: ITarget;
        private var _enemyGO: EnemyGO;

        private var _states: Vector.<IEnemyState>;
        private var _stateIndex: int;

        public function EnemyFSMx(aStates: Vector.<IEnemyState>, aEnemyGO: EnemyGO, aTarget: ITarget)
        {
            _states = aStates;
            _stateIndex = 0;
            _enemyGO = aEnemyGO;
            _target = aTarget;

            startState();
        }

        public function get curentState(): IEnemyState
        {
            return _curentState;
        }

        private function startState(): void
        {
            _curentState = _states[_stateIndex];
            _curentState.start(_enemyGO, _target);
        }

        public function update(aEnemyGO: EnemyGO, aDeltaTime: int): void
        {
            var result: uint = curentState.update(aEnemyGO, aDeltaTime);

            if (result != ACTION_NONE)
                processResult(result);
        }

        private function processResult(aResult: uint): void
        {
            if (aResult == ACTION_NONE)
                return;

            switch (aResult)
            {
                case ACTION_PREV:
                    _stateIndex = Math.max(_stateIndex - 1, 0);
                    break;

                case ACTION_NEXT:
                    _stateIndex = Math.min(_stateIndex + 1, _states.length - 1);
                    break;

                case ACTION_FIRST:
                    _stateIndex = 0;
                    break;

                case ACTION_LAST:
                    _stateIndex = _states.length - 1;
                    break;
            }

            startState();
        }
    }
}
