package game.model.gameObject.component.effect
{
    import game.model.GameObject;
    import game.model.gameObject.component.generator.IGeneratorComponent;

    public class RechargeEffectActionProcessor implements IEffectActionProcessor
    {


        public function RechargeEffectActionProcessor()
        {

        }

        public function process(aEffectVO: EffectVO, aTarget: GameObject, aDamage: Number): void
        {
            var generatorComponent: IGeneratorComponent = IGeneratorComponent(aTarget.getComponent(IGeneratorComponent));
            if (generatorComponent)
                generatorComponent.recharge(aDamage * aEffectVO.param1);

        }
    }
}
