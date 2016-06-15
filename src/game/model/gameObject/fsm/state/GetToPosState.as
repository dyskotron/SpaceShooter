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
            var speedX: Number = _target.x - aEnemyGO.transform.x;
            var speedY: Number = _target.y - aEnemyGO.transform.y;
            var distance: Number = Math.sqrt(speedX * speedX + speedY * speedY);

            if (distance > maxDelta)
            {
                speedX *= maxDelta / distance;
                speedY *= maxDelta / distance;
            }
            aEnemyGO.transform.speedX = speedX;
            aEnemyGO.transform.speedY = speedY;

            aEnemyGO.transform.x += aEnemyGO.transform.speedX;
            aEnemyGO.transform.y += aEnemyGO.transform.speedY;

            if (aEnemyGO.transform.x == _target.x && aEnemyGO.transform.y == _target.y)
                return GameObjectFSM.ACTION_NEXT;

            return GameObjectFSM.ACTION_NONE;
        }
    }
}
