package game.model.gameObject.component.fsm.state
{
    import game.model.GameObject;
    import game.model.gameObject.component.fsm.*;

    public class FlyThroughState extends MovementState implements IEnemyState
    {
        public function FlyThroughState()
        {
        }

        override public function start(aEnemyGO: GameObject, aTarget: ITarget): void
        {

        }

        override public function update(aDeltaTime: Number): uint
        {
            _gameObject.transform.y += _movementParams.speed * aDeltaTime;

            return FSMComponent.ACTION_NONE;
        }
    }
}
