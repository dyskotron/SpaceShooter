package game.model.gameObject.component
{
    import flash.utils.Dictionary;

    import game.model.GameObject;
    import game.model.gameObject.component.effect.property.EffectableProperty;
    import game.model.gameObject.component.effect.property.EffectablePropertyID;

    public class Component implements IComponent
    {
        protected var _properties: Dictionary;

        private var _timeScale: EffectableProperty;

        private var _gameObject: GameObject;
        private var _active: EffectableProperty;

        private var _lifeTime: Number;
        private var _maxLifeTime: Number = 0;

        public function Component(aActive: Boolean = true, aMaxLifeTime: Number = -1)
        {
            _lifeTime = 0;

            _properties ||= new Dictionary();

            _timeScale = new EffectableProperty();
            _timeScale.origValue = 1;
            _timeScale.calculate();
            _properties[EffectablePropertyID.TIME_SCALE] = _timeScale;

            _active = new EffectableProperty();
            _active.origValue = int(aActive);
            _active.calculate();
            _properties[EffectablePropertyID.ACTIVE] = _active;

            _maxLifeTime = aMaxLifeTime;
        }

        public function get active(): Boolean
        {
            return _active.value;
        }

        public function set active(aActive: Boolean): void
        {
            _active.origValue = int(aActive);
        }

        public function get maxLifeTime(): Number
        {
            return _maxLifeTime;
        }

        public function get lifeTime(): Number
        {
            return _lifeTime;
        }

        public function get gameObject(): GameObject
        {
            return _gameObject;
        }

        public function get timeScale(): Number
        {
            return _timeScale.value;
        }

        public function getProperty(aPropertyID: uint): EffectableProperty
        {
            return _properties[aPropertyID];
        }

        public function init(aGameObject: GameObject): void
        {
            _gameObject = aGameObject;
        }

        public function update(aDeltaTime: Number): void
        {
            _lifeTime += aDeltaTime;
        }

        public function terminate(): void
        {

        }

        public function destroy(): void
        {

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
