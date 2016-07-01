package game.model.gameObject.component.fsm.state
{
    import game.model.GameObject;
    import game.model.gameObject.component.fsm.*;

    public class StopState extends MovementState implements IEnemyState
    {
        public function StopState()
        {

        }

        override public function start(aEnemyGO: GameObject, aTarget: ITarget): void
        {
            super.start(aEnemyGO, aTarget);

            _movementParams.speedY = _movementParams.speedX = 0;
        }

        override public function update(aDeltaTime: int): uint
        {
            return FSMComponent.ACTION_NONE;
        }
    }
}
