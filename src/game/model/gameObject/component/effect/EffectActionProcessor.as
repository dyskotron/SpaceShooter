package game.model.gameObject.component.effect
{
    import flash.utils.Dictionary;

    import game.model.GameObject;
    import game.model.gameObject.component.effect.property.HealEffectActionProcessor;
    import game.model.gameObject.constants.EffectID;

    public class EffectActionProcessor implements IEffectActionProcessor
    {
        private var _processors: Dictionary;

        public function EffectActionProcessor()
        {
            _processors = new Dictionary();
            _processors[EffectID.HEAL] = new HealEffectActionProcessor();
            _processors[EffectID.RECHARGE] = new RechargeEffectActionProcessor();
        }

        public function process(aEffectVO: EffectVO, aTarget: GameObject, aDamage: Number): void
        {
            var processor: IEffectActionProcessor = _processors[aEffectVO.effectID];
            if (processor)
                processor.process(aEffectVO, aTarget, aDamage);
        }
    }
}
