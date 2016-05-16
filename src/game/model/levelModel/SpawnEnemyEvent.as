package game.model.levelModel
{
    import game.model.gameObject.vo.EnemyVO;

    public class SpawnEnemyEvent extends SpawnLevelEvent
    {
        private var _aEnemyVO: EnemyVO;


        public function SpawnEnemyEvent(aDistance: Number, aEnemyVO: EnemyVO, aX: Number, aY: Number)
        {
            _aEnemyVO = aEnemyVO;
            super(LevelEvent.ID_SPAWN_ENEMY, aDistance, aX, aY);
        }

        public function get aEnemyVO(): EnemyVO
        {
            return _aEnemyVO;
        }
    }
}
