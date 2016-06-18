package game.model.gameObject.components.fsm.state
{
    import game.model.gameObject.EnemyGO;
    import game.model.gameObject.components.fsm.*;

    public class KamikazeStraightState extends MovementState implements IEnemyState
    {
        private var _speed: Number;

        public function KamikazeStraightState()
        {
        }

        override public function start(aEnemyGO: EnemyGO, aTarget: ITarget): void
        {
            super.start(aEnemyGO, aTarget);

            _speed = _movementParams.speed * 1.5;
        }

        override public function update(aDeltaTime: int): uint
        {
            _speed += _movementParams.speed * 0.1;
            _gameObject.transform.y += _speed * aDeltaTime / 1000;

            return GameObjectFSM.ACTION_NONE;
        }
    }
}
