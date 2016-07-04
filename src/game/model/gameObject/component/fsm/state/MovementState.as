package game.model.gameObject.component.fsm.state
{
    import game.model.GameObject;
    import game.model.gameObject.component.fsm.*;
    import game.model.gameObject.component.movement.MoveParamsComponent;

    public class MovementState implements IEnemyState
    {
        protected var _movementParams: MoveParamsComponent;
        protected var _gameObject: GameObject;

        protected var _currentTime: Number = 0;

        public function MovementState()
        {
        }

        public function start(aEnemyGO: GameObject, aTarget: ITarget): void
        {
            _movementParams = MoveParamsComponent(aEnemyGO.getComponent(MoveParamsComponent));
            _gameObject = aEnemyGO;
        }

        public function update(aDeltaTime: Number): uint
        {
            _currentTime += aDeltaTime;
            return 0;
        }
    }
}
