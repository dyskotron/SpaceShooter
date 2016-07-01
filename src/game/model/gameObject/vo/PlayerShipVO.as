package game.model.gameObject.vo
{
    import game.model.gameObject.component.weapon.ComponentSlot;

    public class PlayerShipVO extends ShootingVO
    {
        public function PlayerShipVO(aTypeID: uint, aWeapons: Vector.<ComponentSlot>, aInitialHP: Number, aWidth: Number, aHeight: Number)
        {
            super(aTypeID, aWeapons, aInitialHP, aWidth, aHeight);
        }
    }
}
