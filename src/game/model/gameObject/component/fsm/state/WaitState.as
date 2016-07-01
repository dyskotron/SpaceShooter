package game.model.gameObject.component.fsm.state
{
    import game.model.GameObject;
    import game.model.gameObject.component.fsm.*;

    public class WaitState extends MovementState implements IEnemyState
    {
        private var _delay: int;
        private var _currentDelay: int;

        public function WaitState(aDelay: int)
        {
            _delay = aDelay;
        }

        override public function start(aEnemyGO: GameObject, aTarget: ITarget): void
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
                return FSMComponent.ACTION_NEXT;
            }

            return FSMComponent.ACTION_NONE;
        }
    }
}
