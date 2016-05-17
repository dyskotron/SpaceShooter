package game.model.gameObject
{
    import game.model.gameObject.vo.BulletVO;

    public class BulletGO extends SimpleMovingGO
    {
        private var _ownerID: uint;
        private var _bulletVO: BulletVO;

        public function BulletGO(aOwnerID: int, aBulletVO: BulletVO, aX: Number, aY: Number, aSpeedX: Number = 0, aSpeedY: Number = 0)
        {
            super(aBulletVO, aX, aY, aSpeedX, aSpeedY);

            _ownerID = aOwnerID;
            _bulletVO = aBulletVO;
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
            _rotation = Math.atan2(_speedX, -_speedY);

            super.update(aDeltaTime);
        }
    }
}
