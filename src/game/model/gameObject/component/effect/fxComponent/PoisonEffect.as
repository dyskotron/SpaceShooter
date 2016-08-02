package game.model.gameObject.component.effect.fxComponent
{
    import game.model.GameObject;
    import game.model.gameObject.component.Component;
    import game.model.gameObject.component.health.HealthComponent;

    public class PoisonEffect extends Component
    {
        private var _health: HealthComponent;
        private var _nextHitLifeTime: Number = 0;
        private var _interval: Number;
        private var _singleDamage: Number;

        private var _hitter: GameObject;

        public function PoisonEffect(aHitter: GameObject, aLength: Number, aDamage: Number, aInterval: Number = 0.8): void
        {
            _hitter = aHitter;
            _interval = aInterval;
            _singleDamage = aDamage / Math.floor(aLength / aInterval);
            super(true, aLength);
        }

        override public function init(aGameObject: GameObject): void
        {
            super.init(aGameObject);
            _health = HealthComponent(gameObject.getComponent(HealthComponent));
        }

        override public function update(aDeltaTime: Number): void
        {
            super.update(aDeltaTime);

            if (lifeTime > _nextHitLifeTime)
            {
                _health.hit(_singleDamage, _hitter);
                trace("_MO_", this, "HIT", _health.hp, _health.maxHP);
                _nextHitLifeTime += _interval;
            }
        }
    }
}
