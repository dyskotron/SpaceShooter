package game.model.gameObject.enemy.state
{
    import game.model.gameObject.EnemyGO;
    import game.model.gameObject.enemy.*;

    import starling.utils.MathUtil;

    public class ChasingState implements IEnemyState
    {
        private var _target: ITarget;

        public function ChasingState()
        {
        }

        public function start(aEnemyGO: EnemyGO, aTarget: ITarget)
        {
            _target = aTarget;
        }

        public function update(aEnemyGO: EnemyGO, aDeltaTime: int)
        {
            var maxDelta: Number = aEnemyGO.maxSpeed * aDeltaTime / 1000;
            aEnemyGO.speedX = MathUtil.clamp((_target.x - aEnemyGO.x), -maxDelta, maxDelta);
            aEnemyGO.speedY = MathUtil.clamp((_target.y - aEnemyGO.y), aEnemyGO.minSpeed * aDeltaTime / 1000, maxDelta);

            aEnemyGO.x += aEnemyGO.speedX;
            aEnemyGO.y += aEnemyGO.speedY;
            aEnemyGO.rotation = Math.atan2(aEnemyGO.speedX, aEnemyGO.speedY);
        }
    }
}
