package game.model.gameObject.fsm.state
{
    import game.model.gameObject.EnemyGO;
    import game.model.gameObject.fsm.*;

    public class WaitState implements IEnemyState
    {
        private var _delay: int;

        public function WaitState(aDelay: int)
        {
            _delay = aDelay;
        }

        public function start(aEnemyGO: EnemyGO, aTarget: ITarget): void
        {
            aEnemyGO.speedY = aEnemyGO.speedX = 0;
        }

        public function update(aEnemyGO: EnemyGO, aDeltaTime: int): uint
        {
            _delay -= aDeltaTime;

            if (_delay <= 0)
            {
                return GameObjectFSM.ACTION_NEXT;
            }

            return GameObjectFSM.ACTION_NONE;
        }
    }
}
