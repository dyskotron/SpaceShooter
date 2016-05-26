package game.model.levelModel
{
    import game.model.gameObject.vo.BehaviorVO;
    import game.model.gameObject.vo.EnemyVO;

    public class SpawnEnemyEvent extends SpawnLevelEvent
    {
        private var _behaviorVO: BehaviorVO;
        private var _aEnemyVO: EnemyVO;


        public function SpawnEnemyEvent(aEnemyVO: EnemyVO, aBehaviorVO: BehaviorVO, aDistance: Number, aX: Number, aY: Number)
        {
            _aEnemyVO = aEnemyVO;
            _behaviorVO = aBehaviorVO;

            super(LevelEvent.ID_SPAWN_ENEMY, aDistance, aX, aY);
        }

        public function get aEnemyVO(): EnemyVO
        {
            return _aEnemyVO;
        }

        public function get behaviorVO(): BehaviorVO
        {
            return _behaviorVO;
        }
    }
}
