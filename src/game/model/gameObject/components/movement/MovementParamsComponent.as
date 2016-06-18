package game.model.gameObject.components.movement
{
    import game.model.gameObject.components.Component;

    public class MovementParamsComponent extends Component
    {
        public var speed: Number;
        public var speedX: Number;
        public var speedY: Number;

        public function MovementParamsComponent(aSpeed: Number = 0)
        {
            speed = aSpeed;
            super(false);

        }
    }
}
