package game.model.gameObject
{
    import flash.utils.Dictionary;

    import game.model.gameObject.constants.BulletMode;
    import game.model.gameObject.vo.BulletVO;

    public class BulletGO extends SimpleMovingGO
    {
        private var _ownerID: uint;
        private var _bulletVO: BulletVO;
        private var _hittedGO: Dictionary;

        public function BulletGO(aOwnerID: int, aBulletVO: BulletVO, aX: Number, aY: Number, aSpeedX: Number = 0, aSpeedY: Number = 0)
        {
            super(aBulletVO, aX, aY, aSpeedX, aSpeedY);

            _ownerID = aOwnerID;
            _bulletVO = aBulletVO;

            if (_bulletVO.mode == BulletMode.EACH_ONCE)
                _hittedGO = new Dictionary();
        }

        public function get bulletVO(): BulletVO
        {
            return _bulletVO;
        }

        public function get ownerID(): uint
        {
            return _ownerID;
        }

        override public function update(aDeltaTime: int): void
        {
            rotation = Math.atan2(speedX, -speedY);

            super.update(aDeltaTime);
        }

        public function canHit(enemyGO: HittableGO): Boolean
        {
            if (_bulletVO.mode == BulletMode.EACH_ONCE && _hittedGO[enemyGO])
                return false;

            return true;
        }

        /**
         * Returns if bullet should be removed after hit or not
         * @param enemyGO
         * @return
         */
        public function hitObject(enemyGO: HittableGO): Boolean
        {
            enemyGO.hit(_bulletVO.damage);

            if (_bulletVO.mode == BulletMode.ONE_SHOT)
                return true;

            if (_bulletVO.mode == BulletMode.EACH_ONCE)
                _hittedGO[enemyGO] = true;

            return false;

        }
    }
}
