package game.model
{
    import game.model.gameObject.components.IComponent;
    import game.model.gameObject.components.collider.IColliderComponent;
    import game.model.gameObject.components.collider.SquareColliderComponent;
    import game.model.gameObject.components.transform.TransformComponent;
    import game.model.gameObject.vo.GameObjectVO;

    public class GameObject
    {
        //TODO: gameobject factory will take care of this
        public static var nextGameObjectID: int = 0;


        private var _currentTime: int = 0;
        private var _gameObjectVO: GameObjectVO;

        private var _transform: TransformComponent;
        private var _collider: IColliderComponent;

        private var _components: Vector.<IComponent>;
        private var _gameObjectID: int;


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
            _gameObjectID = nextGameObjectID++;

            _components = new Vector.<IComponent>();

            //transform
            _transform = new TransformComponent(_gameObjectVO.width, _gameObjectVO.height);
            _transform.x = aX;
            _transform.y = aY;
            _transform.speedX = aSpeedX;
            _transform.speedY = aSpeedY;
            addComponent(_transform);

            _collider = createCollider();
            if (_collider)
                addComponent(_collider);

            initComponents();
        }

        //region ========================================= SETTERS & GETTERS  ==========================================

        public function get transform(): TransformComponent
        {
            return _transform;
        }

        public function get collider(): IColliderComponent
        {
            //TODO FIXME OHGODKILLME UGLY TEMPORARY PUNK
            if (!_collider)
                _collider = IColliderComponent(getComponent(IColliderComponent));

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

        public function get gameObjectID(): uint
        {
            return _gameObjectID;
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

        public function addComponent(aComponent: IComponent): void
        {
            if (aComponent == null)
                throw new Error("Component cant be null");

            _components.push(aComponent);

            initComponents();
        }

        public function addComponents(aComponents: Vector.<IComponent>): void
        {
            for (var i: int = 0; i < aComponents.length; i++)
            {
                if (aComponents[i] == null)
                    throw new Error("Component cant be null");

                _components.push(aComponents[i]);
            }

            initComponents();
        }

        //todo: remove component, make init components public

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

        protected function createCollider(): IColliderComponent
        {
            return new SquareColliderComponent();
        }

        protected function initComponents(): void
        {
            for (var i: int = 0; i < _components.length; i++)
            {
                _components[i].init(this);
            }
        }
    }
}
