package game.model.levelModel
{
    import game.model.gameObject.vo.BonusVO;

    public class SpawnBonusEvent extends SpawnLevelEvent
    {
        private var _aBonusVO: BonusVO;


        public function SpawnBonusEvent(aDistance: Number, aBonusVO: BonusVO, aX: Number, aY: Number)
        {
            _aBonusVO = aBonusVO;
            super(LevelEvent.ID_SPAWN_BONUS, aDistance, aX, aY);
        }

        public function get aBonusVO(): BonusVO
        {
            return _aBonusVO;
        }
    }
}
