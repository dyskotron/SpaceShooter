package game.model.gameObject.enemy.state
{
    import flash.utils.getTimer;

    import game.model.gameObject.EnemyGO;
    import game.model.gameObject.enemy.*;

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
        }

        public function update(aEnemyGO: EnemyGO, aDeltaTime: int): uint
        {
            aEnemyGO.y += aEnemyGO.maxSpeed * aDeltaTime / 1000;
            aEnemyGO.x = _startX + Math.sin((_startTime - getTimer()) / 500) * aEnemyGO.maxSpeed / 2;

            return EnemyFSMx.ACTION_NONE;
        }
    }
}
