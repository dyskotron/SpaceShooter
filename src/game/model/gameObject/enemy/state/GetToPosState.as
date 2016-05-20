package game.model.gameObject.enemy.state
{
    import game.model.gameObject.EnemyGO;
    import game.model.gameObject.enemy.*;

    import starling.utils.MathUtil;

    public class GetToPosState implements IEnemyState
    {
        private var _target: ITarget;

        public function GetToPosState()
        {
        }

        public function start(aEnemyGO: EnemyGO, aTarget: ITarget)
        {
            _target = aTarget;
        }

        public function update(aEnemyGO: EnemyGO, aDeltaTime: int)
        {
            var maxDelta: Number = aEnemyGO.maxSpeed * aDeltaTime / 1000;
            aEnemyGO.speedX = MathUtil.clamp(_target.x - aEnemyGO.x, -maxDelta, maxDelta);
            aEnemyGO.x += aEnemyGO.speedX;
            aEnemyGO.speedY = MathUtil.clamp(_target.y - aEnemyGO.y, -maxDelta, maxDelta);
            aEnemyGO.y += aEnemyGO.speedY;

            //todo return next state
            if (aEnemyGO.x == _target.x && aEnemyGO.y == _target.y)
                return;
        }
    }
}
