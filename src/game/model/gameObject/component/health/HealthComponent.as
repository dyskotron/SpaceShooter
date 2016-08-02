package game.model.gameObject.component.health
{
    import game.model.GameObject;
    import game.model.gameObject.component.Component;
    import game.model.gameObject.eventbus.events.DiedEvent;
    import game.model.gameObject.eventbus.events.HitEvent;

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

        public function hit(aDamage: Number, aHitter: GameObject): void
        {
            _hp -= aDamage;

            gameObject.eventBus.fireEvent(new HitEvent(aDamage, aHitter, gameObject));

            if (hp <= 0)
                die(aHitter);
        }

        public function addHitPoints(aValue: uint): void
        {
            _hp = Math.min(_hp + aValue, _maxHP);
        }

        public function setFullHealth(): void
        {
            _hp = _maxHP;
        }

        protected function die(aHitter: GameObject): void
        {
            gameObject.eventBus.fireEvent(new DiedEvent(aHitter, gameObject));
        }
    }
}
