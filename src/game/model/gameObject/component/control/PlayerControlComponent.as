package game.model.gameObject.component.control
{
    import game.model.GameObject;
    import game.model.gameObject.component.Component;
    import game.model.gameObject.component.movement.MoveParamsComponent;
    import game.model.gameObject.component.transform.TransformComponent;

    public class PlayerControlComponent extends Component
    {
        public static const MOVE_EASING: Number = 0.4;

        /**
         * Coordinates where player ship is heading to.
         * it stores mouse position for mouse controller
         * or "keyboard position" emulated from keys presses by KeyController
         */
        public var controlX: Number;
        public var controlY: Number;

        private var _transform: TransformComponent;
        private var _movementParams: MoveParamsComponent;

        public function PlayerControlComponent()
        {
        }

        override public function init(aGameObject: GameObject): void
        {
            super.init(aGameObject);

            _transform = gameObject.transform;
            _movementParams = MoveParamsComponent(gameObject.getComponent(MoveParamsComponent));
        }

        public function initControl(aX: Number, aY: Number): void
        {
            _transform.x = controlX = aX;
            _transform.y = controlY = aY;
        }

        override public function update(aDeltaTime: int): void
        {
            _movementParams.speedX = (controlX - _transform.x) * MOVE_EASING;
            _movementParams.speedY = (controlY - _transform.y) * MOVE_EASING;

            _transform.x += _movementParams.speedX;
            _transform.y += _movementParams.speedY;
        }
    }
}
