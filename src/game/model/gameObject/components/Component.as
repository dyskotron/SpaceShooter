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
    }
}
