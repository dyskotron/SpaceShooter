package game.model.gameObject.fsm.state
{
    import game.model.gameObject.EnemyGO;
    import game.model.gameObject.fsm.*;

    public class StopState implements IEnemyState
    {
        private var _target: ITarget;

        public function StopState()
        {

        }

        public function start(aEnemyGO: EnemyGO, aTarget: ITarget): void
        {
            aEnemyGO.physics.speedY = aEnemyGO.physics.speedX = 0;
        }

        public function update(aEnemyGO: EnemyGO, aDeltaTime: int): uint
        {
            return GameObjectFSM.ACTION_NONE;
        }
    }
}
