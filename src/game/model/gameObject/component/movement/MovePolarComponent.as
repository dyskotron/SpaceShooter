package game.model.gameObject.component.movement
{
    import game.model.GameObject;
    import game.model.gameObject.component.Component;
    import game.model.gameObject.component.transform.TransformComponent;

    public class MovePolarComponent extends Component implements IMoveComponent
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

            var moveComp: MoveParamsComponent = MoveParamsComponent(aGameObject.getComponent(MoveParamsComponent));
            moveComp.speedX = _speedX;
            moveComp.speedY = _speedY;
        }

        override public function update(aDeltaTime: Number): void
        {
            _transform.x += _speedX * aDeltaTime;
            _transform.y += _speedY * aDeltaTime;
        }

    }
}
