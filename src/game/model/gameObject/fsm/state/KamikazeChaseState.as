package game.model.gameObject.fsm.state
{
    import game.model.gameObject.EnemyGO;
    import game.model.gameObject.fsm.*;

    public class KamikazeChaseState implements IEnemyState
    {
        private static const SPEEDING_RATIO: Number = 2;
        private var _speed: Number;

        public function KamikazeChaseState()
        {
        }

        public function start(aEnemyGO: EnemyGO, aTarget: ITarget): void
        {
            var distX: Number = aTarget.x - aEnemyGO.x;
            var distY: Number = aTarget.y - aEnemyGO.y;
            var dist: Number = Math.sqrt(distX * distX + distY * distY);

            aEnemyGO.speedX = distX / dist * aEnemyGO.enemyVO.speed * SPEEDING_RATIO;
            aEnemyGO.speedY = distY / dist * aEnemyGO.enemyVO.speed * SPEEDING_RATIO;
            aEnemyGO.rotation = Math.atan2(-aEnemyGO.speedX, aEnemyGO.speedY);
        }

        public function update(aEnemyGO: EnemyGO, aDeltaTime: int): uint
        {
            aEnemyGO.x += aEnemyGO.speedX * aDeltaTime / 1000;
            aEnemyGO.y += aEnemyGO.speedY * aDeltaTime / 1000;

            aEnemyGO.speedX *= 1 + aDeltaTime / 1000;
            aEnemyGO.speedY *= 1 + aDeltaTime / 1000;

            return GameObjectFSM.ACTION_NONE;
        }
    }
}
