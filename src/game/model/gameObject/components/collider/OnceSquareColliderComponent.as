package game.model.gameObject.components.collider
{
    import flash.utils.Dictionary;

    public class OnceSquareColliderComponent extends SquareColliderComponent implements IOnceColliderComponent
    {
        private var _collisions: Dictionary;

        public function OnceSquareColliderComponent()
        {
            _collisions = new Dictionary();
        }

        override public function checkCollision(aCollider: IColliderComponent): Boolean
        {
            if (_collisions[aCollider] == true)
                return false;

            return super.checkCollision(aCollider);
        }

        public function markAsHit(aCollider: IColliderComponent): void
        {
            _collisions[aCollider] = true
        }
    }
}
