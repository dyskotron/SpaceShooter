package game.model.gameObject.component.transform
{
    import game.model.gameObject.component.Component;
    import game.model.gameObject.component.fsm.ITarget;

    public class TransformComponent extends Component implements ITarget
    {

        public var width: Number;
        public var height: Number;
        public var rotation: Number;

        private var _x: Number;
        private var _y: Number;

        public function TransformComponent(aWidth: Number, aHeight: Number)
        {
            _x = 0;
            _y = 0;
            width = aWidth;
            height = aHeight;
            rotation = 0;

            super(false);
        }

        public function get x(): Number
        {
            return _x;
        }

        public function set x(value: Number): void
        {
            _x = value;
        }

        public function get y(): Number
        {
            return _y;
        }

        public function set y(value: Number): void
        {
            _y = value;
        }
    }
}
