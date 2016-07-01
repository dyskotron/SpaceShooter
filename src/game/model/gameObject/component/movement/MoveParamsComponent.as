package game.model.gameObject.component.movement
{
    import game.model.gameObject.component.Component;

    public class MoveParamsComponent extends Component
    {
        public var speed: Number = 0;
        public var speedX: Number = 0;
        public var speedY: Number = 0;

        public function MoveParamsComponent(aSpeed: Number = 0)
        {
            speed = aSpeed;
            super(false);
        }
    }
}
