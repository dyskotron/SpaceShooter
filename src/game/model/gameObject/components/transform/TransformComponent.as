package game.model.gameObject.components.transform
{
    import game.model.gameObject.components.Component;
    import game.model.gameObject.fsm.ITarget;

    public class TransformComponent extends Component implements ITarget
    {
        private var _y: Number;
        private var _x: Number;
        private var _width: Number;
        private var _height: Number;
        private var _speedX: Number;
        private var _speedY: Number;
        private var _rotation: Number;

        public function TransformComponent(aWidth: Number, aHeight: Number)
        {
            _y = 0;
            _x = 0;
            _width = aWidth;
            _height = aHeight;
            _speedX = 0;
            _speedY = 0;
            _rotation = 0;
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

        public function get speedX(): Number
        {
            return _speedX;
        }

        public function set speedX(value: Number): void
        {
            _speedX = value;
        }

        public function get speedY(): Number
        {
            return _speedY;
        }

        public function set speedY(value: Number): void
        {
            _speedY = value
        }

        public function get rotation(): Number
        {
            return _rotation;
        }

        public function set rotation(avalue: Number): void
        {
            _rotation = avalue;
        }

        public function get width(): Number
        {
            return _width;
        }

        public function get height(): Number
        {
            return _height;
        }

        override public function update(deltaTime: int): void
        {

        }
    }
}
