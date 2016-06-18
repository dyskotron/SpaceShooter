package game.model.gameObject.components.fsm.state
{
    import game.model.GameObject;
    import game.model.gameObject.components.fsm.*;

    public class WobbleState extends MovementState implements IEnemyState
    {
        private var _target: ITarget;
        private var _startTime: int;
        private var _startX: Number;

        public function WobbleState()
        {
        }

        override public function start(aEnemyGO: GameObject, aTarget: ITarget): void
        {
            super.start(aEnemyGO, aTarget);

            _startTime = aEnemyGO.currentTime;
            _startX = aEnemyGO.transform.x;
            _target = aTarget;

            _movementParams.speedY = _movementParams.speed;
        }

        override public function update(aDeltaTime: int): uint
        {
            _gameObject.transform.y += _movementParams.speedY * aDeltaTime / 1000;

            var oldX: Number = _gameObject.transform.x;
            _gameObject.transform.x = _startX + Math.sin((_startTime - _gameObject.currentTime) / 500) * _movementParams.speed / 2;
            _movementParams.speedX = (oldX - _gameObject.transform.x) / (aDeltaTime / 1000);
            _gameObject.transform.rotation = Math.atan2(_movementParams.speedX, _movementParams.speedY);

            return GameObjectFSM.ACTION_NONE;
        }
    }
}
