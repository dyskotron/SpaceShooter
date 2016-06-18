package game.model.gameObject.components.fsm
{
    import game.model.gameObject.EnemyGO;

    public interface IEnemyState
    {
        function start(aEnemyGO: EnemyGO, aTarget: ITarget): void

        function update(aDeltaTime: int): uint
    }
}
