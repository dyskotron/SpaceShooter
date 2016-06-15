package game.model.gameObject.fsm.state
{
    import game.model.gameObject.EnemyGO;
    import game.model.gameObject.fsm.*;

    public class KamikazeChaseState implements IEnemyState
    {
        private static const SPEEDING_RATIO: Number = 2;

        public function KamikazeChaseState()
        {
        }

        public function start(aEnemyGO: EnemyGO, aTarget: ITarget): void
        {
            var distX: Number = aTarget.x - aEnemyGO.transform.x;
            var distY: Number = aTarget.y - aEnemyGO.transform.y;
            var dist: Number = Math.sqrt(distX * distX + distY * distY);

            aEnemyGO.transform.speedX = distX / dist * aEnemyGO.enemyVO.speed * SPEEDING_RATIO;
            aEnemyGO.transform.speedY = distY / dist * aEnemyGO.enemyVO.speed * SPEEDING_RATIO;
            aEnemyGO.transform.rotation = Math.atan2(-aEnemyGO.transform.speedX, aEnemyGO.transform.speedY);
        }

        public function update(aEnemyGO: EnemyGO, aDeltaTime: int): uint
        {
            aEnemyGO.transform.x += aEnemyGO.transform.speedX * aDeltaTime / 1000;
            aEnemyGO.transform.y += aEnemyGO.transform.speedY * aDeltaTime / 1000;

            aEnemyGO.transform.speedX *= 1 + aDeltaTime / 1000;
            aEnemyGO.transform.speedY *= 1 + aDeltaTime / 1000;

            return GameObjectFSM.ACTION_NONE;
        }
    }
}
