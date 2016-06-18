package game.model.gameObject.components.fsm.state
{
    import game.model.GameObject;
    import game.model.gameObject.components.fsm.*;

    import starling.utils.MathUtil;

    public class GetToXposState extends MovementState implements IEnemyState
    {
        private var _target: ITarget;

        public function GetToXposState(aTarget: ITarget = null)
        {
            _target = aTarget;
        }

        override public function start(aEnemyGO: GameObject, aTarget: ITarget): void
        {
            super.start(aEnemyGO, aTarget);

            _target ||= aTarget;
            _movementParams.speedX = _movementParams.speed;
            _movementParams.speedY = 0;
        }

        override public function update(aDeltaTime: int): uint
        {
            var maxDelta: Number = _movementParams.speed * aDeltaTime / 1000;
            var delta: Number = MathUtil.clamp(_target.x - _gameObject.transform.x, -maxDelta, maxDelta);
            _gameObject.transform.x += delta;

            if (_gameObject.transform.x == _target.x)
                return GameObjectFSM.ACTION_NEXT;

            return GameObjectFSM.ACTION_NONE;
        }
    }
}
