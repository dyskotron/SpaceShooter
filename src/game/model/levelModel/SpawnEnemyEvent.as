package game.model.levelModel
{
    import game.model.gameObject.fsm.ITarget;
    import game.model.gameObject.vo.EnemyVO;

    public class SpawnEnemyEvent extends SpawnLevelEvent
    {
        private var _aEnemyVO: EnemyVO;
        private var _target: ITarget;


        public function SpawnEnemyEvent(aEnemyVO: EnemyVO, aTarget: ITarget, aDistance: Number, aX: Number, aY: Number)
        {
            _aEnemyVO = aEnemyVO;
            _target = aTarget;

            super(LevelEvent.ID_SPAWN_ENEMY, aDistance, aX, aY);
        }

        public function get aEnemyVO(): EnemyVO
        {
            return _aEnemyVO;
        }

        public function get target(): ITarget
        {
            return _target;
        }
    }
}
