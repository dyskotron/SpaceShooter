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
            _startX = aEnemyGO.transform.x;
            _target = aTarget;

            aEnemyGO.transform.speedY = aEnemyGO.enemyVO.speed;
        }

        public function update(aEnemyGO: EnemyGO, aDeltaTime: int): uint
        {
            aEnemyGO.transform.y += aEnemyGO.transform.speedY * aDeltaTime / 1000;

            var oldX: Number = aEnemyGO.transform.x;
            aEnemyGO.transform.x = _startX + Math.sin((_startTime - aEnemyGO.currentTime) / 500) * aEnemyGO.enemyVO.speed / 2;

            aEnemyGO.transform.speedX = (oldX - aEnemyGO.transform.x) / (aDeltaTime / 1000);

            aEnemyGO.transform.rotation = Math.atan2(aEnemyGO.transform.speedX, aEnemyGO.transform.speedY);

            return GameObjectFSM.ACTION_NONE;
        }
    }
}
