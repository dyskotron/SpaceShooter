package game.model.gameObject.enemy
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
    }
}
