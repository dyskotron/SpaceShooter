package game.model.gameObject.component.movement
{
    import game.model.gameObject.component.Component;
    import game.model.gameObject.component.effect.property.EffectableProperty;
    import game.model.gameObject.component.effect.property.EffectablePropertyID;

    public class MoveParamsComponent extends Component
    {
        private var _speed: EffectableProperty;
        public var speedX: Number = 0;
        public var speedY: Number = 0;

        public function MoveParamsComponent(aSpeed: Number = 0)
        {
            super(false);

            _speed = new EffectableProperty();
            _speed.origValue = aSpeed;
            _speed.calculate();

            _properties[EffectablePropertyID.SPEED] = _speed;
        }

        public function get speed(): Number
        {
            return _speed.value;
        }
    }
}
