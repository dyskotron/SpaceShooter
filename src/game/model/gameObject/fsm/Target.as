package game.model.gameObject.fsm
{
    public class Target implements ITarget
    {
        private var _x: Number;
        private var _y: Number;

        public function Target(aX: Number = 0, aY: Number = 0): void
        {
            _x = aX;
            _y = aY;
        }

        public function get x(): Number
        {
            return _x;
        }

        public function get y(): Number
        {
            return _y;
        }

        public function getAngleFromCoords(aX: Number, aY: Number): Number
        {
            return Math.atan2(_x - aX, _y - aY);
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

        public function toString(): String
        {
            return "x: " + _x + " y: " + _y;
        }
    }
}
