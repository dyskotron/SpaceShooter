package game.model.gameObject.component
{
    import game.model.GameObject;

    public class Container extends Component implements IContainer
    {
        private var _components: Vector.<IComponent>;

        public function Container(aActive: Boolean = true)
        {
            active = aActive;
        }

        override public function init(aGameObject: GameObject): void
        {
            _components = new Vector.<IComponent>();
            super.init(aGameObject);
        }

        override public function update(aDeltaTime: Number): void
        {
            for (var i: int = _components.length - 1; i >= 0; i--)
            {
                if (_components[i].active)
                {
                    _components[i].update(aDeltaTime);
                    if (_components[i].maxLifeTime >= 0)
                    {
                        if (_components[i].lifeTime > _components[i].maxLifeTime)
                            removeComponentAt(i);
                    }
                }
            }
        }

        public function addComponent(aComponent: IComponent): void
        {
            trace("_MO_", this, "Container - addComponent", aComponent);
            _components.push(aComponent);
            aComponent.init(gameObject);
        }

        public function removeComponent(aComponent: IComponent): void
        {
            trace("_MO_", this, "Container - removeComponent");

            for (var i: int = 0; i < _components.length; i++)
            {
                if (_components[i] == aComponent)
                {
                    aComponent.terminate();
                    _components.splice(i, 1);
                    return;
                }
            }
        }

        public function removeComponentAt(index: int): void
        {
            trace("_MO_", this, "Container - removeComponentAt");

            if (_components.length > index)
            {
                _components[index].terminate();
                _components.splice(index, 1);
            }
        }
    }
}
