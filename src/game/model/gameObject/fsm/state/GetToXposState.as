package game.model.gameObject.fsm.state
{
    import game.model.gameObject.EnemyGO;
    import game.model.gameObject.fsm.*;

    import starling.utils.MathUtil;

    public class GetToXposState implements IEnemyState
    {
        private var _target: ITarget;

        public function GetToXposState(aTarget: ITarget = null)
        {
            _target = aTarget;
        }

        public function start(aEnemyGO: EnemyGO, aTarget: ITarget): void
        {
            _target ||= aTarget;
            aEnemyGO.physics.speedX = aEnemyGO.enemyVO.speed;
            aEnemyGO.physics.speedY = 0;
        }

        public function update(aEnemyGO: EnemyGO, aDeltaTime: int): uint
        {
            var maxDelta: Number = aEnemyGO.enemyVO.speed * aDeltaTime / 1000;
            var delta: Number = MathUtil.clamp(_target.x - aEnemyGO.physics.x, -maxDelta, maxDelta);
            aEnemyGO.physics.x += delta;

            if (aEnemyGO.physics.x == _target.x)
                return GameObjectFSM.ACTION_NEXT;

            return GameObjectFSM.ACTION_NONE;
        }
    }
}
