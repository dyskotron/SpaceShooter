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
            aEnemyGO.transform.speedX = 0;
            aEnemyGO.transform.speedY = aEnemyGO.enemyVO.speed;
        }

        public function update(aEnemyGO: EnemyGO, aDeltaTime: int): uint
        {
            var maxDelta: Number = aEnemyGO.enemyVO.speed * aDeltaTime / 1000;
            var delta: Number = MathUtil.clamp(_target.y - aEnemyGO.transform.y, -maxDelta, maxDelta);
            aEnemyGO.transform.y += delta;

            if (aEnemyGO.transform.y == _target.y)
                return GameObjectFSM.ACTION_NEXT;

            return GameObjectFSM.ACTION_NONE;
        }
    }
}
