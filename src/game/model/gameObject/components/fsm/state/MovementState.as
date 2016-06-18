package game.model.gameObject.components.fsm.state
{
    import game.model.GameObject;
    import game.model.gameObject.components.fsm.*;
    import game.model.gameObject.components.movement.MovementParamsComponent;

    public class MovementState implements IEnemyState
    {
        protected var _movementParams: MovementParamsComponent;
        protected var _gameObject: GameObject;

        public function MovementState()
        {
        }

        public function start(aEnemyGO: GameObject, aTarget: ITarget): void
        {
            _movementParams = MovementParamsComponent(aEnemyGO.getComponent(MovementParamsComponent));
            _gameObject = aEnemyGO;
        }

        public function update(aDeltaTime: int): uint
        {
            return 0;
        }
    }
}
