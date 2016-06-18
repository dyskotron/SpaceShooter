package game.model.gameObject.components.fsm.state
{
    import game.model.GameObject;
    import game.model.gameObject.components.fsm.*;
    import game.model.gameObject.components.movement.MoveParamsComponent;

    public class MovementState implements IEnemyState
    {
        protected var _movementParams: MoveParamsComponent;
        protected var _gameObject: GameObject;

        public function MovementState()
        {
        }

        public function start(aEnemyGO: GameObject, aTarget: ITarget): void
        {
            _movementParams = MoveParamsComponent(aEnemyGO.getComponent(MoveParamsComponent));
            _gameObject = aEnemyGO;
        }

        public function update(aDeltaTime: int): uint
        {
            return 0;
        }
    }
}
