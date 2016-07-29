package game.model
{
    import game.model.gameObject.GameObjectIdentity;
    import game.model.gameObject.component.IComponent;
    import game.model.gameObject.component.IContainer;
    import game.model.gameObject.component.collider.IColliderComponent;
    import game.model.gameObject.component.health.IHealthComponent;
    import game.model.gameObject.component.transform.TransformComponent;

    public class GameObject implements IContainer
    {
        private var _currentTime: int = 0;

        private var _transform: TransformComponent;
        private var _identity: GameObjectIdentity;
        private var _collider: IColliderComponent;

        private var _components: Vector.<IComponent>;

        private var _healthComponent: IHealthComponent;


        /**
         * base class representing all game objects e.g. player ships enemies bullets etc
         *
         * @param aIdentity - gameObject's ID, type, and other identifiers
         * @param aX - keeps track of object instance X position
         * @param aY - keeps track of object instance Y position
         * @param aHeight - GameObject's width
         * @param aWidth - GameObject's height
         */
        public function GameObject(aIdentity: GameObjectIdentity, aX: Number, aY: Number, aWidth: Number, aHeight: Number)
        {
            _identity = aIdentity;

            _components = new Vector.<IComponent>();

            //transform
            _transform = new TransformComponent(aWidth, aHeight);
            _transform.x = aX;
            _transform.y = aY;
            addComponent(_transform);

            initComponents();
        }

        //region ========================================= SETTERS & GETTERS  ==========================================

        public function get transform(): TransformComponent
        {
            return _transform;
        }

        public function get identity(): GameObjectIdentity
        {
            return _identity;
        }

        public function get collider(): IColliderComponent
        {
            return _collider;
        }

        public function get healthComponent(): IHealthComponent
        {
            return _healthComponent;
        }

        public function get currentTime(): int
        {
            return _currentTime;
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

            if (aComponent is IColliderComponent)
                _collider = IColliderComponent(aComponent);

            if (aComponent is IHealthComponent)
                _healthComponent = IHealthComponent(aComponent);

            aComponent.init(this);

            _components.push(aComponent);
        }

        public function addComponents(aComponents: Vector.<IComponent>): void
        {
            if (aComponents == null)
                throw new Error("Components cant be null");
            else if (aComponents.length == 0)
                throw new Error("Components cant be empty");

            for (var i: int = 0; i < aComponents.length; i++)
            {
                aComponents[i].init(this);
                _components.push(aComponents[i]);
            }

        }

        public function initComponents(): void
        {
            for (var i: int = 0; i < _components.length; i++)
            {
                _components[i].init(this);
            }
        }

        public function removeComponent(component: IComponent): void
        {
            //TODO
        }

        public function removeComponentAt(index: int): void
        {
            //TODO
        }

        //endregion

        public function update(aDeltaTime: Number): void
        {
            _currentTime += aDeltaTime;

            for (var i: int = 0; i < _components.length; i++)
            {
                if (_components[i].active)
                {
                    _components[i].update(aDeltaTime);
                }
            }
        }

        public function destroy(): void
        {

        }

    }
}
