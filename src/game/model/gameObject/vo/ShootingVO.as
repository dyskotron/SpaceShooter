package game.model.gameObject.vo
{
    import game.model.weapon.WeaponModel;

    public class ShootingVO extends HittableVO
    {
        private var _weaponVO: WeaponModel;

        public function ShootingVO(aTypeID: uint, aWeaponVO: WeaponModel, aInitialHP: int, aWidth: Number, aHeight: Number)
        {
            _weaponVO = aWeaponVO;
            super(aTypeID, aInitialHP, aWidth, aHeight);
        }

        public function get weaponVO(): WeaponModel
        {
            return _weaponVO;
        }
    }
}
