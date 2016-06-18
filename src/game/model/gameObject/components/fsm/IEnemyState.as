package game.model.gameObject.components.fsm
{
    import game.model.GameObject;

    public interface IEnemyState
    {
        function start(aEnemyGO: GameObject, aTarget: ITarget): void

        function update(aDeltaTime: int): uint
    }
}
