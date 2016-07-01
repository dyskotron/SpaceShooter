package game.model.gameObject.component.movement
{
    import game.model.GameObject;
    import game.model.gameObject.component.Component;
    import game.model.gameObject.component.transform.TransformComponent;

    public class MovePolarComponent extends Component
    {
        private var _transform: TransformComponent;
        private var _speedX: Number;
        private var _speedY: Number;


        public function MovePolarComponent(aSpeed: Number, aAngle: Number): void
        {
            _speedX = aSpeed * Math.sin(aAngle);
            _speedY = aSpeed * Math.cos(aAngle);

        }

        override public function init(aGameObject: GameObject): void
        {
            super.init(aGameObject);
            _transform = aGameObject.transform;
        }

        override public function update(aDeltaTime: int): void
        {
            _transform.x += _speedX * aDeltaTime / 1000;
            _transform.y += _speedY * aDeltaTime / 1000;
        }
    }
}
