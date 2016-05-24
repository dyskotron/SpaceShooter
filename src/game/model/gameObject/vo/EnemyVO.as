package game.model.gameObject.vo
{
    public class EnemyVO extends ShootingVO
    {
        public function EnemyVO(aTypeID: uint, aBulletType: uint, aBulletInterval: int, aInitialHP: Number, aWidth: Number, aHeight: Number)
        {
            super(aTypeID, aInitialHP, aBulletType, aBulletInterval, aWidth, aHeight);
        }
    }
}
