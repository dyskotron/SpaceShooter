package game.model.gameObject.components.collider
{
    public interface IOnceColliderComponent extends IColliderComponent
    {
        function markAsHit(aCollider: IColliderComponent): void
    }
}
