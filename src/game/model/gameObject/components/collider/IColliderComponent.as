package game.model.gameObject.components.collider
{
    import game.model.GameObject;

    public interface IColliderComponent
    {
        function checkCollision(aCollider: IColliderComponent): Boolean;

        function init(aGameObject: GameObject): void

        function update(deltaTime: int): void
    }
}
