package game.model.gameObject.component.fsm.state
{
    import game.model.GameObject;
    import game.model.gameObject.component.fsm.*;

    public class KamikazeStraightState extends MovementState implements IEnemyState
    {
        private var _speed: Number;

        public function KamikazeStraightState()
        {
        }

        override public function start(aEnemyGO: GameObject, aTarget: ITarget): void
        {
            super.start(aEnemyGO, aTarget);

            _speed = _movementParams.speed * 1.5;
        }

        override public function update(aDeltaTime: Number): uint
        {
            _speed += _movementParams.speed * 0.1;
            _gameObject.transform.y += _speed * aDeltaTime;

            return FSMComponent.ACTION_NONE;
        }
    }
}
