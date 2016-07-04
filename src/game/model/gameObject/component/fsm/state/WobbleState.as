package game.model.gameObject.component.fsm.state
{
    import game.model.GameObject;
    import game.model.gameObject.component.fsm.FSMComponent;
    import game.model.gameObject.component.fsm.IEnemyState;
    import game.model.gameObject.component.fsm.ITarget;

    public class WobbleState extends MovementState implements IEnemyState
    {
        private var _startTime: int;
        private var _startX: Number;

        public function WobbleState()
        {

        }

        override public function start(aEnemyGO: GameObject, aTarget: ITarget): void
        {
            super.start(aEnemyGO, aTarget);

            _startTime = _currentTime;
            _startX = aEnemyGO.transform.x;

            _movementParams.speedY = _movementParams.speed;
            _movementParams.speedX = _movementParams.speed / 2;
        }

        override public function update(aDeltaTime: Number): uint
        {
            super.update(aDeltaTime);
            _gameObject.transform.y += _movementParams.speedY * aDeltaTime;
            _gameObject.transform.x = _startX + Math.sin(_startTime - _currentTime) * _movementParams.speedX;
            return FSMComponent.ACTION_NONE;
        }
    }
}
