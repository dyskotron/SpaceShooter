package game.model.gameObject.fsm.state
{
    import game.model.gameObject.EnemyGO;
    import game.model.gameObject.fsm.*;

    public class FlyThroughState implements IEnemyState
    {
        public function FlyThroughState()
        {
        }

        public function start(aEnemyGO: EnemyGO, aTarget: ITarget): void
        {

        }

        public function update(aEnemyGO: EnemyGO, aDeltaTime: int): uint
        {
            aEnemyGO.y += aEnemyGO.enemyVO.speed * aDeltaTime / 1000;

            return GameObjectFSM.ACTION_NONE;
        }
    }
}
