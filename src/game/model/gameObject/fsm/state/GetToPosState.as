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
            var speedX: Number = _target.x - aEnemyGO.physics.x;
            var speedY: Number = _target.y - aEnemyGO.physics.y;
            var distance: Number = Math.sqrt(speedX * speedX + speedY * speedY);

            if (distance > maxDelta)
            {
                speedX *= maxDelta / distance;
                speedY *= maxDelta / distance;
            }
            aEnemyGO.physics.speedX = speedX;
            aEnemyGO.physics.speedY = speedY;

            aEnemyGO.physics.x += aEnemyGO.physics.speedX;
            aEnemyGO.physics.y += aEnemyGO.physics.speedY;

            if (aEnemyGO.physics.x == _target.x && aEnemyGO.physics.y == _target.y)
                return GameObjectFSM.ACTION_NEXT;

            return GameObjectFSM.ACTION_NONE;
        }
    }
}
