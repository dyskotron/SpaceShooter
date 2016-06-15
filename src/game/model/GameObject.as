package game.model
{
    import game.model.gameObject.components.collider.IColliderComponent;
    import game.model.gameObject.components.collider.SquareColliderComponent;
    import game.model.gameObject.components.transform.TransformComponent;
    import game.model.gameObject.vo.GameObjectVO;

    public class GameObject
    {

        private var _currentTime: int = 0;
        private var _gameObjectVO: GameObjectVO;

        private var _transform: TransformComponent;
        private var _collider: IColliderComponent;

        /**
         * base class representing all game objects e.g. player ships enemies bullets etc
         *
         * @param aGameObjectVO - definition for game objects - keep all properties common to all instances of one type
         * @param aX - keeps track of object instance X position
         * @param aY - keeps track of object instance Y position
         * @param aSpeedX - keeps track of object instance X speed
         * @param aSpeedY - keeps track of object instance Y speed
         */
        public function GameObject(aGameObjectVO: GameObjectVO, aX: Number, aY: Number, aSpeedX: Number, aSpeedY: Number)
        {
            _gameObjectVO = aGameObjectVO;

            _transform = new TransformComponent(_gameObjectVO.width, _gameObjectVO.height);
            _transform.x = aX;
            _transform.y = aY;
            _transform.speedX = aSpeedX;
            _transform.speedY = aSpeedY;

            _collider = createCollider();
            _collider.init(this);
        }

        //region ========================================= SETTERS & GETTERS  ==========================================

        public function get transform(): TransformComponent
        {
            return _transform;
        }

        public function get collider(): IColliderComponent
        {
            return _collider;
        }

        public function get currentTime(): int
        {
            return _currentTime;
        }

        public function get gameObjectVO(): GameObjectVO
        {
            return _gameObjectVO;
        }

        //endregion

        public function update(aDeltaTime: int): void
        {
            _currentTime += aDeltaTime;
            _transform.update(aDeltaTime);
            _collider.update(aDeltaTime);
        }

        public function destroy(): void
        {

        }

        protected function createCollider(): IColliderComponent
        {
            return new SquareColliderComponent();
        }
    }
}
