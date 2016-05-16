package game.model.gameObject
{
    import game.model.*;
    import game.model.gameObject.vo.HittableVO;

    public class HittableGO extends GameObject
    {
        private var _hp: int;

        public function HittableGO(aHittableVO: HittableVO, aX: Number, aY: Number, aSpeedX: Number = 0, aSpeedY: Number = 0)
        {
            _hp = aHittableVO.initialHP;
            super(aHittableVO, aX, aY, aSpeedX, aSpeedY);
        }

        public function hit(aDamage: Number): void
        {
            _hp -= aDamage;
        }

        public function get hp(): int
        {
            return _hp;
        }

        public function setFullHealth(): void
        {
            _hp = HittableVO(_gameObjectVO).initialHP;
        }

        public function addHitPoints(aValue: uint): void
        {
            _hp = Math.min(_hp + aValue, HittableVO(_gameObjectVO).initialHP);
        }


    }
}
