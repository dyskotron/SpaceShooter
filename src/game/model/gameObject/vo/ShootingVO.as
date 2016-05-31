package game.model.gameObject.vo
{
    import game.model.weapon.WeaponSlot;

    public class ShootingVO extends HittableVO
    {
        private var _weaponSlots: Vector.<WeaponSlot>;

        public function ShootingVO(aTypeID: uint, aWeapons: Vector.<WeaponSlot>, aInitialHP: int, aWidth: Number, aHeight: Number)
        {
            _weaponSlots = aWeapons;
            super(aTypeID, aInitialHP, aWidth, aHeight);
        }

        public function get weaponSlots(): Vector.<WeaponSlot>
        {
            return _weaponSlots;
        }
    }
}
