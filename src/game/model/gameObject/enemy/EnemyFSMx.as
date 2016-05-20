package game.model.gameObject.enemy
{
    import game.model.gameObject.EnemyGO;

    public class EnemyFSMx
    {
        private var _curentState: IEnemyState;
        private var _stack: Vector.<IEnemyState>;
        private var _target: ITarget;
        private var _enemyGO: EnemyGO;

        public function EnemyFSMx(aEnemyGO: EnemyGO, aTarget: ITarget)
        {
            _stack = new Vector.<IEnemyState>();
            _target = aTarget;
            _enemyGO = aEnemyGO;
        }

        public function popState(): void
        {
            _stack.pop();
            startState();
        }

        public function pushState(aState: IEnemyState): void
        {
            _stack.push(aState);
            startState();
        }

        public function get curentState(): IEnemyState
        {
            return _curentState;
        }

        private function startState(): void
        {
            if (_stack.length > 0)
            {
                _curentState = _stack[_stack.length - 1];
                _curentState.start(_enemyGO, _target);
            }
        }
    }
}
