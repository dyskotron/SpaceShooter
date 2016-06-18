package game.model.gameObject.components.health
{
    import game.model.gameObject.components.Component;

    import org.osflash.signals.Signal;

    public class HealthComponent extends Component implements IHealthComponent
    {
        protected var _state: uint;

        private var _hp: int;
        private var _maxHP: int;
        private var _changeStateSignal: Signal;

        public function HealthComponent(aMaxHP: int)
        {
            _hp = _maxHP = aMaxHP;
            _state = HealthState.ALIVE;
            _changeStateSignal = new Signal(IHealthComponent);
        }

        public function get changeStateSignal(): Signal
        {
            return _changeStateSignal;
        }

        public function get hp(): int
        {
            return _hp;
        }

        public function get maxHP(): int
        {
            return _maxHP;
        }


        public function get state(): uint
        {
            return _state;
        }

        public function hit(aDamage: Number): void
        {
            _hp -= aDamage;
        }

        public function addHitPoints(aValue: uint): void
        {
            _hp = Math.min(_hp + aValue, _maxHP);
        }

        public function setFullHealth(): void
        {
            _hp = _maxHP;
        }
    }
}
