package game.model.gameObject.component.movement
{
    import game.model.GameObject;
    import game.model.gameObject.component.Component;
    import game.model.gameObject.component.transform.TransformComponent;

    public class MoveLinearY extends Component
    {
        private var _transform: TransformComponent;
        private var _speed: Number;


        public function MoveLinearY(aSpeed: Number): void
        {
            _speed = aSpeed;
        }

        override public function init(aGameObject: GameObject): void
        {
            super.init(aGameObject);
            _transform = aGameObject.transform;

        }

        override public function update(aDeltaTime: Number): void
        {
            _transform.y += _speed * aDeltaTime;

        }
    }
}
