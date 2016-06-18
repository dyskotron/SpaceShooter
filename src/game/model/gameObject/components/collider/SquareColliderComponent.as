package game.model.gameObject.components.collider
{
    import flash.geom.Rectangle;

    import game.model.GameObject;
    import game.model.gameObject.components.Component;

    public class SquareColliderComponent extends Component implements IColliderComponent
    {
        private var _bounds: Rectangle;

        public function SquareColliderComponent()
        {
        }

        public function get bounds(): Rectangle
        {
            return _bounds;
        }

        public function checkCollision(aCollider: IColliderComponent): Boolean
        {
            if (aCollider is SquareColliderComponent)
            {
                var collider: SquareColliderComponent = SquareColliderComponent(aCollider);
                return collider.bounds.intersects(_bounds);
            }

            return false;
        }

        override public function init(aGameObject: GameObject): void
        {
            _bounds = new Rectangle(aGameObject.transform.x - aGameObject.transform.width * 0.5,
                                    aGameObject.transform.y - aGameObject.transform.height * 0.5,
                                    aGameObject.transform.width,
                                    aGameObject.transform.height);

            super.init(aGameObject);

        }

        override public function update(deltaTime: int): void
        {
            _bounds.x = gameObject.transform.x - gameObject.transform.width * 0.5;
            _bounds.y = gameObject.transform.y - gameObject.transform.height * 0.5;
            _bounds.width = gameObject.transform.width;
            _bounds.height = gameObject.transform.height;
        }
    }
}
