package game.model.gameObject.vo
{
    public class EnemyVO extends ShootingVO
    {
        private var _behaviorID: uint;

        public function EnemyVO(aTypeID: uint, aBehaviorID: uint, aBulletType: uint, aBulletInterval: int, aInitialHP: Number, aWidth: Number, aHeight: Number)
        {
            _behaviorID = aBehaviorID;
            super(aTypeID, aInitialHP, aBulletType, aBulletInterval, aWidth, aHeight);
        }

        public function get behaviorID(): uint
        {
            return _behaviorID;
        }
    }
}
