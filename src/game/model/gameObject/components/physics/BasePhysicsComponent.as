package game.model.gameObject.components.physics
{
    import flash.geom.Rectangle;

    import game.model.gameObject.fsm.ITarget;

    public class BasePhysicsComponent implements IPhysicsComponent, ITarget
    {
        private var _bounds: Rectangle;
        private var _y: Number;
        private var _x: Number;
        private var _speedX: Number;
        private var _speedY: Number;
        private var _rotation: Number;

        public function BasePhysicsComponent(aWidth: Number, aHeight: Number)
        {
            _bounds = new Rectangle(0, 0, aWidth, aHeight);
            _y = 0;
            _x = 0;
            _speedX = 0;
            _speedY = 0;
            _rotation = 0;
        }

        public function set x(value: Number): void
        {
            _x = value;
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

        public function get bounds(): Rectangle
        {
            return _bounds;
        }

        public function get x(): Number
        {
            return _x;
        }

        public function get y(): Number
        {
            return _y;
        }

        public function update(deltaTime: int): void
        {
            _bounds.x = _x - _bounds.width / 2;
            _bounds.y = _y - _bounds.height / 2;
        }


        //TODO: remove
        public function getAngleFromCoords(aX: Number, aY: Number): Number
        {
            return Math.atan2(x - aX, y - aY);
        }

        public function getAngleDelta(aX: Number, aY: Number, aAngle: Number): Number
        {
            var angleDelta = (Math.PI * 2 + (Math.atan2(x - aX, y - aY) - aAngle)) % (Math.PI * 2);
            if (angleDelta > Math.PI)
                angleDelta = angleDelta - Math.PI * 2;

            return angleDelta;
        }

        public function getDistanceSq(aX: Number, aY: Number): Number
        {
            return Math.pow(x - aX, 2) + Math.pow(y - aY, 2);
        }
    }
}
