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
            aEnemyGO.transform.speedX = aEnemyGO.enemyVO.speed;
            aEnemyGO.transform.speedY = 0;
        }

        public function update(aEnemyGO: EnemyGO, aDeltaTime: int): uint
        {
            var maxDelta: Number = aEnemyGO.enemyVO.speed * aDeltaTime / 1000;
            var delta: Number = MathUtil.clamp(_target.x - aEnemyGO.transform.x, -maxDelta, maxDelta);
            aEnemyGO.transform.x += delta;

            if (aEnemyGO.transform.x == _target.x)
                return GameObjectFSM.ACTION_NEXT;

            return GameObjectFSM.ACTION_NONE;
        }
    }
}
