package game.model.gameObject.components.collider
{
    import game.model.gameObject.components.IComponent;

    public interface IColliderComponent extends IComponent
    {
        function checkCollision(aCollider: IColliderComponent): Boolean;
    }
}
