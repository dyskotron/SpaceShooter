package game.model.gameObject.components.fsm.state
{
    import game.model.gameObject.EnemyGO;
    import game.model.gameObject.components.fsm.*;

    public class FlyThroughState extends MovementState implements IEnemyState
    {
        public function FlyThroughState()
        {
        }

        override public function start(aEnemyGO: EnemyGO, aTarget: ITarget): void
        {

        }

        override public function update(aDeltaTime: int): uint
        {
            _gameObject.transform.y += _movementParams.speed * aDeltaTime / 1000;

            return GameObjectFSM.ACTION_NONE;
        }
    }
}
