package game.model.gameObject.component.fsm
{
    import game.model.GameObject;

    public interface IEnemyState
    {
        function start(aEnemyGO: GameObject, aTarget: ITarget): void

        function update(aDeltaTime: int): uint
    }
}
