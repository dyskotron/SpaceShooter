package game.model.gameObject
{
    import game.model.gameObject.vo.BulletVO;

    public class BulletGO extends SimpleMovingGO
    {
        private var _ownerID: uint;

        public function BulletGO(aOwnerID: int, aBulletVO: BulletVO, aX: Number, aY: Number, aSpeedX: Number = 0, aSpeedY: Number = 0)
        {
            _ownerID = aOwnerID;
            super(aBulletVO, aX, aY, aSpeedX, aSpeedY);
        }

        override public function update(aDeltaTime: int): void
        {
            _rotation = Math.atan2(_speedX, -_speedY);

            super.update(aDeltaTime);
        }

        public function get bulletVO(): BulletVO
        {
            return BulletVO(_gameObjectVO);
        }

        public function get ownerID(): uint
        {
            return _ownerID;
        }
    }
}
