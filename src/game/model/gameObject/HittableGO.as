package game.model.gameObject
{
    import game.model.*;
    import game.model.gameObject.vo.HittableVO;

    public class HittableGO extends GameObject
    {
        private var _hp: int;
        private var _hittableVO: HittableVO;

        public function HittableGO(aHittableVO: HittableVO, aX: Number, aY: Number, aSpeedX: Number = 0, aSpeedY: Number = 0)
        {
            super(aHittableVO, aX, aY, aSpeedX, aSpeedY);

            _hp = aHittableVO.initialHP;
            _hittableVO = aHittableVO;
        }

        public function get hittableVO(): HittableVO
        {
            return _hittableVO;
        }

        public function get hp(): int
        {
            return _hp;
        }

        public function hit(aDamage: Number): void
        {
            _hp -= aDamage;
        }

        public function setFullHealth(): void
        {
            _hp = HittableVO(gameObjectVO).initialHP;
        }

        public function addHitPoints(aValue: uint): void
        {
            _hp = Math.min(_hp + aValue, _hittableVO.initialHP);
        }
    }
}
