package game.model.gameObject.vo
{
    import game.model.gameObject.constants.BulletType;

    public class PlayerShipVO extends ShootingVO
    {
        public function PlayerShipVO(aTypeID: uint, aInitialHP: Number, aWidth: Number, aHeight: Number)
        {
            super(aTypeID, aInitialHP, BulletType.LASER, 200, aWidth, aHeight);
        }
    }
}
