package game.model.gameObject.fsm.state
{
    import game.model.gameObject.EnemyGO;
    import game.model.gameObject.fsm.*;

    import starling.utils.MathUtil;

    public class GetToYposState implements IEnemyState
    {
        private var _target: ITarget;

        public function GetToYposState(aTarget: ITarget = null)
        {
            _target = aTarget;
        }

        public function start(aEnemyGO: EnemyGO, aTarget: ITarget): void
        {
            _target ||= aTarget;
            aEnemyGO.physics.speedX = 0;
            aEnemyGO.physics.speedY = aEnemyGO.enemyVO.speed;
        }

        public function update(aEnemyGO: EnemyGO, aDeltaTime: int): uint
        {
            var maxDelta: Number = aEnemyGO.enemyVO.speed * aDeltaTime / 1000;
            var delta: Number = MathUtil.clamp(_target.y - aEnemyGO.physics.y, -maxDelta, maxDelta);
            aEnemyGO.physics.y += delta;

            if (aEnemyGO.physics.y == _target.y)
                return GameObjectFSM.ACTION_NEXT;

            return GameObjectFSM.ACTION_NONE;
        }
    }
}
