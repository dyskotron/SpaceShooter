package game.model.gameObject.component.fsm.state
{
    import game.model.GameObject;
    import game.model.gameObject.component.fsm.*;

    public class KamikazeChaseState extends MovementState implements IEnemyState
    {
        private static const SPEEDING_RATIO: Number = 2;

        public function KamikazeChaseState()
        {
        }

        override public function start(aEnemyGO: GameObject, aTarget: ITarget): void
        {
            super.start(aEnemyGO, aTarget);

            var distX: Number = aTarget.x - aEnemyGO.transform.x;
            var distY: Number = aTarget.y - aEnemyGO.transform.y;
            var dist: Number = Math.sqrt(distX * distX + distY * distY);

            _movementParams.speedX = distX / dist * _movementParams.speed * SPEEDING_RATIO;
            _movementParams.speedY = distY / dist * _movementParams.speed * SPEEDING_RATIO;
            _gameObject.transform.rotation = Math.atan2(-_movementParams.speedX, _movementParams.speedY);
        }

        override public function update(aDeltaTime: Number): uint
        {
            _gameObject.transform.x += _movementParams.speedX * aDeltaTime;
            _gameObject.transform.y += _movementParams.speedY * aDeltaTime;

            _movementParams.speedX *= 1 + aDeltaTime;
            _movementParams.speedY *= 1 + aDeltaTime;

            return FSMComponent.ACTION_NONE;
        }
    }
}
