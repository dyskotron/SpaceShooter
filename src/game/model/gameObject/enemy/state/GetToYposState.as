package game.model.gameObject.enemy.state
{
    import game.model.gameObject.EnemyGO;
    import game.model.gameObject.enemy.*;

    import starling.utils.MathUtil;

    public class GetToYposState implements IEnemyState
    {
        private var _target: ITarget;

        public function GetToYposState()
        {
        }

        public function start(aEnemyGO: EnemyGO, aTarget: ITarget): void
        {
            _target = aTarget;
            aEnemyGO.speedX = 0;
        }

        public function update(aEnemyGO: EnemyGO, aDeltaTime: int): uint
        {
            var maxDelta: Number = aEnemyGO.maxSpeed * aDeltaTime / 1000;
            aEnemyGO.speedY = MathUtil.clamp(_target.y - aEnemyGO.y, -maxDelta, maxDelta);
            aEnemyGO.y += aEnemyGO.speedY;

            if (aEnemyGO.y == _target.y)
                return EnemyFSMx.ACTION_NEXT;

            return EnemyFSMx.ACTION_NONE;
        }
    }
}
