package game.model.gameObject.enemy.state
{
    import game.model.gameObject.EnemyGO;
    import game.model.gameObject.enemy.*;

    public class FlyThroughState implements IEnemyState
    {
        public function FlyThroughState()
        {
        }

        public function start(aEnemyGO: EnemyGO,aTarget: ITarget)
        {

        }

        public function update(aEnemyGO: EnemyGO, aDeltaTime: int)
        {
            aEnemyGO.y += aEnemyGO.maxSpeed * aDeltaTime / 1000;
        }
    }
}
