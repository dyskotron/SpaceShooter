package game.model.gameObject.vo
{
    import game.model.weapon.WeaponVO;

    public class ShootingVO extends HittableVO
    {
        private var _weaponVO: WeaponVO;

        public function ShootingVO(aTypeID: uint, aWeaponVO: WeaponVO, aInitialHP: int, aWidth: Number, aHeight: Number)
        {
            _weaponVO = aWeaponVO;
            super(aTypeID, aInitialHP, aWidth, aHeight);
        }

        public function get weaponVO(): WeaponVO
        {
            return _weaponVO;
        }
    }
}
