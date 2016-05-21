package game.model.gameObject.enemy.state
{
    import game.model.gameObject.EnemyGO;
    import game.model.gameObject.enemy.*;

    import starling.utils.MathUtil;

    public class GetToXposState implements IEnemyState
    {
        private var _target: ITarget;

        public function GetToXposState()
        {
        }

        public function start(aEnemyGO: EnemyGO, aTarget: ITarget): void
        {
            _target = aTarget;
            aEnemyGO.speedY = 0;
        }

        public function update(aEnemyGO: EnemyGO, aDeltaTime: int): uint
        {
            var maxDelta: Number = aEnemyGO.maxSpeed * aDeltaTime / 1000;
            aEnemyGO.speedX = MathUtil.clamp(_target.x - aEnemyGO.x, -maxDelta, maxDelta);
            aEnemyGO.x += aEnemyGO.speedX;

            if (aEnemyGO.x == _target.x)
                return EnemyFSMx.ACTION_NEXT;

            return EnemyFSMx.ACTION_NONE;
        }
    }
}
