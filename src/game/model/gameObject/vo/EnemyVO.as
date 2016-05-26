package game.model.gameObject.vo
{
    public class EnemyVO extends ShootingVO
    {
        private var _speed: uint;

        public function EnemyVO(aTypeID: uint, aSpeed: uint, aBulletType: uint, aBulletInterval: int, aInitialHP: Number, aWidth: Number, aHeight: Number)
        {
            _speed = aSpeed;
            super(aTypeID, aInitialHP, aBulletType, aBulletInterval, aWidth, aHeight);
        }

        public function get speed(): uint
        {
            return _speed;
        }
    }
}
