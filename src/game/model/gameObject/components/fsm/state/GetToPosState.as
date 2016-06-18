package game.model.gameObject.components.fsm.state
{
    import game.model.gameObject.EnemyGO;
    import game.model.gameObject.components.fsm.*;

    public class GetToPosState extends MovementState implements IEnemyState
    {
        private var _target: ITarget;

        public function GetToPosState(aTarget: ITarget = null)
        {
            _target = aTarget;
        }

        override public function start(aEnemyGO: EnemyGO, aTarget: ITarget): void
        {
            super.start(aEnemyGO, aTarget);

            _target ||= aTarget;
        }

        override public function update(aDeltaTime: int): uint
        {
            var maxDelta: Number = _movementParams.speed * aDeltaTime / 1000;
            var speedX: Number = _target.x - _gameObject.transform.x;
            var speedY: Number = _target.y - _gameObject.transform.y;
            var distance: Number = Math.sqrt(speedX * speedX + speedY * speedY);

            if (distance > maxDelta)
            {
                speedX *= maxDelta / distance;
                speedY *= maxDelta / distance;
            }
            _movementParams.speedX = speedX;
            _movementParams.speedY = speedY;

            _gameObject.transform.x += _movementParams.speedX;
            _gameObject.transform.y += _movementParams.speedY;

            if (_gameObject.transform.x == _target.x && _gameObject.transform.y == _target.y)
                return GameObjectFSM.ACTION_NEXT;

            return GameObjectFSM.ACTION_NONE;
        }
    }
}
