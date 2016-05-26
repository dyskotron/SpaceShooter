package game.model.gameObject.fsm.state
{
    import game.model.gameObject.EnemyGO;
    import game.model.gameObject.fsm.*;

    public class GetToPosState implements IEnemyState
    {
        private var _target: ITarget;

        public function GetToPosState(aTarget: ITarget = null)
        {
            _target = aTarget;
        }

        public function start(aEnemyGO: EnemyGO, aTarget: ITarget): void
        {
            _target ||= aTarget;
        }

        public function update(aEnemyGO: EnemyGO, aDeltaTime: int): uint
        {
            var maxDelta: Number = aEnemyGO.enemyVO.speed * aDeltaTime / 1000;
            var speedX: Number = _target.x - aEnemyGO.x;
            var speedY: Number = _target.y - aEnemyGO.y;
            var distance: Number = Math.sqrt(speedX * speedX + speedY * speedY);

            if (distance > maxDelta)
            {
                speedX *= maxDelta / distance;
                speedY *= maxDelta / distance;
            }
            aEnemyGO.speedX = speedX;
            aEnemyGO.speedY = speedY;

            aEnemyGO.x += aEnemyGO.speedX;
            aEnemyGO.y += aEnemyGO.speedY;

            if (aEnemyGO.x == _target.x && aEnemyGO.y == _target.y)
                return GameObjectFSM.ACTION_NEXT;

            return GameObjectFSM.ACTION_NONE;
        }
    }
}
