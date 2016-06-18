package game.model.gameObject.components.movement
{
    import game.model.GameObject;
    import game.model.gameObject.components.Component;
    import game.model.gameObject.components.transform.TransformComponent;

    public class MoveLinearY extends Component
    {
        private var _moveParams: MoveParamsComponent;
        private var _transform: TransformComponent;

        override public function init(aGameObject: GameObject): void
        {
            super.init(aGameObject);
            _moveParams = MoveParamsComponent(aGameObject.getComponent(MoveParamsComponent));
            _transform = aGameObject.transform;

        }

        override public function update(aDeltaTime: int): void
        {
            _transform.y += _moveParams.speedY * aDeltaTime;

        }
    }
}
