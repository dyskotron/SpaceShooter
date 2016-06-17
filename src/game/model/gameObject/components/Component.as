package game.model.gameObject.components
{
    import game.model.GameObject;

    public class Component implements IComponent
    {
        private var _gameObject: GameObject;
        private var _enabled: Boolean;

        public function Component()
        {
        }

        public function get gameObject(): GameObject
        {
            return _gameObject;
        }

        public function init(aGameObject: GameObject): void
        {
            _gameObject = aGameObject;
        }

        public function update(deltaTime: int): void
        {

        }

        public function get enabled(): Boolean
        {
            return _enabled;
        }

        public function set enabled(aEnabled: Boolean): void
        {
            _enabled = aEnabled;
        }

        protected function hasGOComponent(aComponentClass: Class): Boolean
        {
            return _gameObject.hasComponent(aComponentClass);
        }

        protected function getGOComponent(aComponentClass: Class): IComponent
        {
            return _gameObject.getComponent(aComponentClass);
        }

        protected function getGOComponents(aComponentClass: Class): Vector.<IComponent>
        {
            return _gameObject.getComponents(aComponentClass);
        }
    }
}
