package game.model.gameObject.component.collider
{
    public interface IOnceColliderComponent extends IColliderComponent
    {
        function markAsHit(aCollider: IColliderComponent): void
    }
}
