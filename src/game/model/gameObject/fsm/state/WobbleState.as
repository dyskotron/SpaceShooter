package game.model.gameObject.fsm.state
{
    import game.model.gameObject.EnemyGO;
    import game.model.gameObject.fsm.*;

    public class WobbleState implements IEnemyState
    {
        private var _target: ITarget;
        private var _startTime: int;
        private var _startX: Number;

        public function WobbleState()
        {
        }

        public function start(aEnemyGO: EnemyGO, aTarget: ITarget): void
        {
            _startTime = aEnemyGO.currentTime;
            _startX = aEnemyGO.physics.x;
            _target = aTarget;

            aEnemyGO.physics.speedY = aEnemyGO.enemyVO.speed;
        }

        public function update(aEnemyGO: EnemyGO, aDeltaTime: int): uint
        {
            aEnemyGO.physics.y += aEnemyGO.physics.speedY * aDeltaTime / 1000;

            var oldX: Number = aEnemyGO.physics.x;
            aEnemyGO.physics.x = _startX + Math.sin((_startTime - aEnemyGO.currentTime) / 500) * aEnemyGO.enemyVO.speed / 2;

            aEnemyGO.physics.speedX = (oldX - aEnemyGO.physics.x) / (aDeltaTime / 1000);

            aEnemyGO.physics.rotation = Math.atan2(aEnemyGO.physics.speedX, aEnemyGO.physics.speedY);

            return GameObjectFSM.ACTION_NONE;
        }
    }
}
