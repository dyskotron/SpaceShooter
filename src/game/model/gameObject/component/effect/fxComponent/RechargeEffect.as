package game.model.gameObject.component.effect.fxComponent
{
    import game.model.GameObject;
    import game.model.gameObject.component.Component;
    import game.model.gameObject.component.health.HealthComponent;

    public class RechargeEffect extends Component
    {
        private var _health: HealthComponent;
        private var _damage: Number;

        public function RechargeEffect(aDamage: Number): void
        {
            _damage = aDamage;
            super(true, 0);
        }

        override public function init(aGameObject: GameObject): void
        {
            super.init(aGameObject);
            _health = HealthComponent(gameObject.getComponent(HealthComponent));
            _health.addHitPoints(_damage)
        }

        override public function update(aDeltaTime: Number): void
        {

        }
    }
}
