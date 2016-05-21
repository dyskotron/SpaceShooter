package game.model.gameObject.enemy
{
    import game.model.gameObject.EnemyGO;

    public interface IEnemyState
    {
        function start(aEnemyGO: EnemyGO, aTarget: ITarget): void

        function update(aEnemyGO: EnemyGO, aDeltaTime: int): uint
    }
}
