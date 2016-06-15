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
            var distX: Number = aTarget.x - aEnemyGO.physics.x;
            var distY: Number = aTarget.y - aEnemyGO.physics.y;
            var dist: Number = Math.sqrt(distX * distX + distY * distY);

            aEnemyGO.physics.speedX = distX / dist * aEnemyGO.enemyVO.speed * SPEEDING_RATIO;
            aEnemyGO.physics.speedY = distY / dist * aEnemyGO.enemyVO.speed * SPEEDING_RATIO;
            aEnemyGO.physics.rotation = Math.atan2(-aEnemyGO.physics.speedX, aEnemyGO.physics.speedY);
        }

        public function update(aEnemyGO: EnemyGO, aDeltaTime: int): uint
        {
            aEnemyGO.physics.x += aEnemyGO.physics.speedX * aDeltaTime / 1000;
            aEnemyGO.physics.y += aEnemyGO.physics.speedY * aDeltaTime / 1000;

            aEnemyGO.physics.speedX *= 1 + aDeltaTime / 1000;
            aEnemyGO.physics.speedY *= 1 + aDeltaTime / 1000;

            return GameObjectFSM.ACTION_NONE;
        }
    }
}
