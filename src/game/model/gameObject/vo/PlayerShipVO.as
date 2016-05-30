package game.model.gameObject.vo
{
    import game.model.weapon.WeaponModel;

    public class PlayerShipVO extends ShootingVO
    {
        public function PlayerShipVO(aTypeID: uint, aWeaponVO: WeaponModel, aInitialHP: Number, aWidth: Number, aHeight: Number)
        {
            super(aTypeID, aWeaponVO, aInitialHP, aWidth, aHeight);
        }
    }
}
