package game.model
{
    import game.model.gameObject.components.IComponent;
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

        private var _components: Vector.<IComponent>;

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

            _components = new Vector.<IComponent>();

            //transform
            _transform = new TransformComponent(_gameObjectVO.width, _gameObjectVO.height);
            _transform.x = aX;
            _transform.y = aY;
            _transform.speedX = aSpeedX;
            _transform.speedY = aSpeedY;
            addComponent(_transform);

            _collider = createCollider();
            addComponent(_collider);
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

        //region ========================================== COMPONENTS API =============================================

        public function hasComponent(aComponentClass: Class): Boolean
        {
            for (var i: int = 0; i < _components.length; i++)
            {
                if (_components[i] is aComponentClass)
                    return true

            }

            return false;
        }

        public function getComponent(aComponentClass: Class): IComponent
        {
            for (var i: int = 0; i < _components.length; i++)
            {
                if (_components[i] is aComponentClass)
                    return _components[i]

            }

            return null;
        }

        public function getComponents(aComponentClass: Class): Vector.<IComponent>
        {
            var components: Vector.<IComponent> = new Vector.<IComponent>();

            for (var i: int = 0; i < _components.length; i++)
            {
                if (_components[i] is aComponentClass)
                    components.push(_components[i]);

            }

            return components;
        }

        //endregion

        public function update(aDeltaTime: int): void
        {
            _currentTime += aDeltaTime;

            for (var i: int = 0; i < _components.length; i++)
            {
                _components[i].update(aDeltaTime);
            }
        }

        public function destroy(): void
        {

        }

        protected function addComponent(aComponent: IComponent): void
        {
            aComponent.init(this);
            _components.push(aComponent);
        }

        protected function createCollider(): IColliderComponent
        {
            return new SquareColliderComponent();
        }
    }
}
