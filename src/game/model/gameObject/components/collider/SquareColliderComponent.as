package game.model.gameObject.components.collider
{
    import flash.geom.Rectangle;

    import game.model.GameObject;

    public class SquareColliderComponent implements IColliderComponent
    {
        private var _bounds: Rectangle;
        private var _gameObject: GameObject;

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

        public function init(aGameObject: GameObject): void
        {
            _gameObject = aGameObject;
            _bounds = new Rectangle(_gameObject.transform.x - _gameObject.transform.width * 0.5,
                                    _gameObject.transform.y - _gameObject.transform.height * 0.5,
                                    _gameObject.gameObjectVO.width,
                                    _gameObject.gameObjectVO.height);

        }

        public function update(deltaTime: int): void
        {
            _bounds.x = _gameObject.transform.x - _bounds.width * 0.5;
            _bounds.y = _gameObject.transform.y - _bounds.height * 0.5;
        }
    }
}
