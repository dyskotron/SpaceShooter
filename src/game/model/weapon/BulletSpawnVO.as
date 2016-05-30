package game.model.weapon
{
    import game.model.gameObject.vo.BulletVO;

    public class BulletSpawnVO
    {
        private var _x: Number;
        private var _y: Number;
        private var _speedX: Number;
        private var _speedY: Number;
        private var _bulletVO: BulletVO;

        public function BulletSpawnVO(aBulletVO: BulletVO, aX: Number, aY: Number, aSpeedX: Number = 0, aSpeedY: Number = 0)
        {
            _bulletVO = aBulletVO;

            _x = aX;
            _y = aY;

            _speedX = aSpeedX;
            _speedY = aSpeedY;
        }

        public function get bulletVO(): BulletVO
        {
            return _bulletVO;
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
