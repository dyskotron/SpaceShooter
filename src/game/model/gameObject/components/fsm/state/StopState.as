package game.model.gameObject.components.fsm.state
{
    import game.model.gameObject.EnemyGO;
    import game.model.gameObject.components.fsm.*;

    public class StopState extends MovementState implements IEnemyState
    {
        public function StopState()
        {

        }

        override public function start(aEnemyGO: EnemyGO, aTarget: ITarget): void
        {
            super.start(aEnemyGO, aTarget);

            _movementParams.speedY = _movementParams.speedX = 0;
        }

        override public function update(aDeltaTime: int): uint
        {
            return GameObjectFSM.ACTION_NONE;
        }
    }
}
