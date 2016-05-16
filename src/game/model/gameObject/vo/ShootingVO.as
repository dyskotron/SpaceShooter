package game.model.gameObject.vo
{
    public class ShootingVO extends HittableVO
    {
        private var _shootInterval: int;
        private var _bulletType: int;

        public function ShootingVO(aTypeID: uint, aInitialHP: int, aBulletType: uint, aShootInterval: int, aWidth: Number, aHeight: Number)
        {
            _shootInterval = aShootInterval;
            _bulletType = aBulletType;
            super(aTypeID, aInitialHP, aWidth, aHeight);
        }

        public function get shootInterval(): int
        {
            return _shootInterval;
        }

        public function get bulletType(): int
        {
            return _bulletType;
        }
    }
}
