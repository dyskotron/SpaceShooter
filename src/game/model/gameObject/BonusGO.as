package game.model.gameObject
{
    import game.model.gameObject.vo.BonusVO;

    public class BonusGO extends SimpleMovingGO
    {
        public function BonusGO(abonusVO: BonusVO, aX: Number, aY: Number, aSpeedX: Number = 0, aSpeedY: Number = 0)
        {
            super(abonusVO, aX, aY, aSpeedX, aSpeedY);
        }

        public function get bonusVO(): BonusVO
        {
            return BonusVO(_gameObjectVO);
        }
    }
}
