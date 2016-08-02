package game.model.gameObject.component.effect.property
{
    import game.model.GameObject;
    import game.model.gameObject.component.effect.*;
    import game.model.gameObject.component.health.HealthComponent;

    public class HealEffectActionProcessor implements IEffectActionProcessor
    {


        public function HealEffectActionProcessor()
        {

        }

        public function process(aEffectVO: EffectVO, aTarget: GameObject, aDamage: Number): void
        {
            var healthComponent: HealthComponent = HealthComponent(aTarget.getComponent(HealthComponent));
            if (healthComponent)
                healthComponent.addHitPoints(aDamage * aEffectVO.param1);
        }
    }
}
