package game.model.gameObject.fsm.state
{
    import flash.utils.getTimer;

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
            _startTime = getTimer();
            _startX = aEnemyGO.x;
            _target = aTarget;

            aEnemyGO.speedY = aEnemyGO.maxSpeed;
        }

        public function update(aEnemyGO: EnemyGO, aDeltaTime: int): uint
        {
            aEnemyGO.y += aEnemyGO.speedY * aDeltaTime / 1000;

            var oldX: Number = aEnemyGO.x;
            aEnemyGO.x = _startX + Math.sin((_startTime - getTimer()) / 500) * aEnemyGO.maxSpeed / 2;

            aEnemyGO.speedX = (oldX - aEnemyGO.x) / (aDeltaTime / 1000);

            aEnemyGO.rotation = Math.atan2(aEnemyGO.speedX, aEnemyGO.speedY);

            return GameObjectFSM.ACTION_NONE;
        }
    }
}
