package game.model.gameObject.fsm
{
    public class Target implements ITarget
    {
        private var _x: Number;
        private var _y: Number;

        //region STATIC METHODS
        public static function getAngleFromCoords(aTarget: ITarget, aX: Number, aY: Number): Number
        {
            return Math.atan2(aTarget.x - aX, aTarget.y - aY);
        }

        public static function getAngleDelta(aTarget: ITarget, aX: Number, aY: Number, aAngle: Number): Number
        {
            var angleDelta: Number = (Math.PI * 2 + (Math.atan2(aTarget.x - aX, aTarget.y - aY) - aAngle)) % (Math.PI * 2);
            if (angleDelta > Math.PI)
                angleDelta = angleDelta - Math.PI * 2;

            return angleDelta;
        }

        public static function getDistanceSq(aTarget: ITarget, aX: Number, aY: Number): Number
        {
            return Math.pow(aTarget.x - aX, 2) + Math.pow(aTarget.y - aY, 2);
        }

        //endregion

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

        public function toString(): String
        {
            return "x: " + _x + " y: " + _y;
        }
    }
}
