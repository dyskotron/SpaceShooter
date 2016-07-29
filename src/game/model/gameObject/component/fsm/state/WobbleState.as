package game.model.gameObject.component.fsm.state
{
    import game.model.GameObject;
    import game.model.gameObject.component.fsm.FSMComponent;
    import game.model.gameObject.component.fsm.IEnemyState;
    import game.model.gameObject.component.fsm.ITarget;

    public class WobbleState extends MovementState implements IEnemyState
    {
        private var _startTime: int;
        private var _oldX: Number = 0;
        private var _newX: Number = 0;
        private var _width: Number;

        public function WobbleState(aWidth: Number)
        {
            _width = aWidth;
        }

        override public function start(aEnemyGO: GameObject, aTarget: ITarget): void
        {
            super.start(aEnemyGO, aTarget);

            _startTime = _currentTime;
        }

        override public function update(aDeltaTime: Number): uint
        {
            //super.update(aDeltaTime);

            //todo: how dare you mess with delta time?!
            _currentTime += aDeltaTime * _movementParams.speed / 200;

            _gameObject.transform.y += _movementParams.speed * aDeltaTime;

            _newX = Math.sin(_startTime - _currentTime) * _width;
            _gameObject.transform.x += _newX - _oldX;
            _oldX = _newX;

            return FSMComponent.ACTION_NONE;
        }
    }
}
