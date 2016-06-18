package game.model.gameObject.components.fsm.state
{
    import game.model.gameObject.EnemyGO;
    import game.model.gameObject.components.fsm.*;

    public class WaitState extends MovementState implements IEnemyState
    {
        private var _delay: int;
        private var _currentDelay: int;

        public function WaitState(aDelay: int)
        {
            _delay = aDelay;
        }

        override public function start(aEnemyGO: EnemyGO, aTarget: ITarget): void
        {
            super.start(aEnemyGO, aTarget);

            _movementParams.speedY = _movementParams.speedX = 0;
            _currentDelay = _delay;
        }

        override public function update(aDeltaTime: int): uint
        {
            _currentDelay -= aDeltaTime;

            if (_currentDelay <= 0)
            {
                return GameObjectFSM.ACTION_NEXT;
            }

            return GameObjectFSM.ACTION_NONE;
        }
    }
}
