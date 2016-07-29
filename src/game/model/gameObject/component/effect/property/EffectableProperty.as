package game.model.gameObject.component.effect.property
{
    public class EffectableProperty
    {
        private var _currentValue: Number;
        private var _origValue: Number;

        private var _replaceOrig: Boolean = false;
        private var _absolute: Number = 0;
        private var _additive: Number = 0;
        private var _multiplicative: Number = 1;

        public function EffectableProperty()
        {

        }

        public function get value(): Number
        {
            return _currentValue;
        }

        public function set origValue(value: Number): void
        {
            _origValue = value;
        }

        public function set replaceOrig(value: Boolean): void
        {
            _replaceOrig = value;
        }

        public function set absolute(value: Number): void
        {
            _absolute = value;
        }

        public function set additive(value: Number): void
        {
            _additive = value;
        }

        public function set multiplicative(value: Number): void
        {
            _multiplicative = value;
        }

        public function calculate(): void
        {
            if (_replaceOrig)
                _currentValue = (_absolute + _additive) * (1 + _multiplicative);
            else
                _currentValue = (_origValue + _additive) * (1 + _multiplicative);
        }
    }
}
