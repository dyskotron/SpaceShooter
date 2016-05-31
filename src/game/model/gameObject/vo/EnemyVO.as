package game.model.gameObject.vo
{
    import game.model.weapon.WeaponModel;

    public class EnemyVO extends ShootingVO
    {
        private var _speed: uint;

        public function EnemyVO(aTypeID: uint, aSpeed: uint, aWeaponVO: WeaponModel, aInitialHP: Number, aWidth: Number, aHeight: Number)
        {
            _speed = aSpeed;
            super(aTypeID, aWeaponVO, aInitialHP, aWidth, aHeight);
        }

        public function get speed(): uint
        {
            return _speed;
        }
    }
}
