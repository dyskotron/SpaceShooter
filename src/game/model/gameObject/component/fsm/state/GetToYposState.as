package game.model.gameObject.component.fsm.state
{
    import game.model.GameObject;
    import game.model.gameObject.component.fsm.*;

    import starling.utils.MathUtil;

    public class GetToYposState extends MovementState implements IEnemyState
    {
        private var _target: ITarget;

        public function GetToYposState(aTarget: ITarget = null)
        {
            _target = aTarget;
        }

        override public function start(aEnemyGO: GameObject, aTarget: ITarget): void
        {
            super.start(aEnemyGO, aTarget);

            _target ||= aTarget;
            _movementParams.speedX = 0;
            _movementParams.speedY = _movementParams.speed;
        }

        override public function update(aDeltaTime: Number): uint
        {
            var maxDelta: Number = _movementParams.speed * aDeltaTime;
            var delta: Number = MathUtil.clamp(_target.y - _gameObject.transform.y, -maxDelta, maxDelta);
            _gameObject.transform.y += delta;

            if (_gameObject.transform.y == _target.y)
                return FSMComponent.ACTION_NEXT;

            return FSMComponent.ACTION_NONE;
        }
    }
}
