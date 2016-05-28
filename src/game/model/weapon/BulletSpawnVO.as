package game.model.weapon
{
    public class BulletSpawnVO
    {
        private var _x: Number;
        private var _y: Number;
        private var _speedX: Number;
        private var _speedY: Number;

        public function BulletSpawnVO(aX: Number, aY: Number, aSpeedX: Number = 0, aSpeedY: Number = 0)
        {
            _x = aX;
            _y = aY;
            _speedX = aSpeedX;
            _speedY = aSpeedY;
        }

        public function get x(): Number
        {
            return _x;
        }

        public function get y(): Number
        {
            return _y;
        }

        public function get speedX(): Number
        {
            return _speedX;
        }

        public function get speedY(): Number
        {
            return _speedY;
        }
    }
}
