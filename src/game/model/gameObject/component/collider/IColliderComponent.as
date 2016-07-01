package game.model.gameObject.component.collider
{
    import game.model.gameObject.component.IComponent;

    public interface IColliderComponent extends IComponent
    {
        function checkCollision(aCollider: IColliderComponent): Boolean;
    }
}
