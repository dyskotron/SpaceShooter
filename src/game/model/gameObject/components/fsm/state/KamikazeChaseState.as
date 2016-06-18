package game.model.gameObject.components.fsm.state
{
    import game.model.gameObject.EnemyGO;
    import game.model.gameObject.components.fsm.*;

    public class KamikazeChaseState extends MovementState implements IEnemyState
    {
        private static const SPEEDING_RATIO: Number = 2;

        public function KamikazeChaseState()
        {
        }

        override public function start(aEnemyGO: EnemyGO, aTarget: ITarget): void
        {
            super.start(aEnemyGO, aTarget);

            var distX: Number = aTarget.x - aEnemyGO.transform.x;
            var distY: Number = aTarget.y - aEnemyGO.transform.y;
            var dist: Number = Math.sqrt(distX * distX + distY * distY);

            _movementParams.speedX = distX / dist * _movementParams.speed * SPEEDING_RATIO;
            _movementParams.speedY = distY / dist * _movementParams.speed * SPEEDING_RATIO;
            _gameObject.transform.rotation = Math.atan2(-_movementParams.speedX, _movementParams.speedY);
        }

        override public function update(aDeltaTime: int): uint
        {
            _gameObject.transform.x += _movementParams.speedX * aDeltaTime / 1000;
            _gameObject.transform.y += _movementParams.speedY * aDeltaTime / 1000;

            _movementParams.speedX *= 1 + aDeltaTime / 1000;
            _movementParams.speedY *= 1 + aDeltaTime / 1000;

            return GameObjectFSM.ACTION_NONE;
        }
    }
}
