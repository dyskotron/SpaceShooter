package game.model.gameObject.vo
{
    import game.model.weapon.WeaponModel;

    public class ShootingVO extends HittableVO
    {
        private var _weaponModels: Vector.<WeaponModel>;

        public function ShootingVO(aTypeID: uint, aWeapons: Vector.<WeaponModel>, aInitialHP: int, aWidth: Number, aHeight: Number)
        {
            _weaponModels = aWeapons;
            super(aTypeID, aInitialHP, aWidth, aHeight);
        }

        public function get weaponModels(): Vector.<WeaponModel>
        {
            return _weaponModels;
        }
    }
}
