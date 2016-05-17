package game.model.gameObject
{
    import game.model.gameObject.vo.BonusVO;

    public class BonusGO extends SimpleMovingGO
    {
        private var _bonusVO: BonusVO;

        public function BonusGO(aBonusVO: BonusVO, aX: Number, aY: Number, aSpeedX: Number = 0, aSpeedY: Number = 0)
        {
            super(aBonusVO, aX, aY, aSpeedX, aSpeedY);

            _bonusVO = aBonusVO;
        }

        public function get bonusVO(): BonusVO
        {
            return _bonusVO;
        }
    }
}
