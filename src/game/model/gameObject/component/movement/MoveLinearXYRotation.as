package game.model.gameObject.component.movement
{
    import game.model.GameObject;
    import game.model.gameObject.component.Component;
    import game.model.gameObject.component.transform.TransformComponent;

    public class MoveLinearXYRotation extends Component
    {
        private var _transform: TransformComponent;
        private var _speedX: Number;
        private var _speedY: Number;
        private var _speedRotation: Number;

        public function MoveLinearXYRotation(aSpeedX: Number, aSpeedY: Number, aSpeedRotation: Number): void
        {
            _speedX = aSpeedX;
            _speedY = aSpeedY;
            _speedRotation = aSpeedRotation;
        }

        override public function init(aGameObject: GameObject): void
        {
            super.init(aGameObject);
            _transform = aGameObject.transform;
        }

        override public function update(aDeltaTime: int): void
        {
            //TODO: there should be aDeltaTime / 1000, change values generated in SerialLevelGenerator accordingly
            _transform.x += _speedX * aDeltaTime / 1000;
            _transform.y += _speedY * aDeltaTime / 1000;
            _transform.rotation += _speedRotation * aDeltaTime;
        }
    }
}
