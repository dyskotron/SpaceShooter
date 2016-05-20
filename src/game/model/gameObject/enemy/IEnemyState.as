package game.model.gameObject.enemy
{
    import game.model.gameObject.EnemyGO;

    public interface IEnemyState
    {
        function start(aEnemyGO: EnemyGO,aTarget: ITarget);

        function update(aEnemyGO: EnemyGO, aDeltaTime: int);
    }
}
