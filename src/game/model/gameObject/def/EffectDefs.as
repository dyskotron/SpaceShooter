package game.model.gameObject.def
{
    import game.model.gameObject.component.effect.EffectTargetID;
    import game.model.gameObject.component.effect.EffectVO;
    import game.model.gameObject.constants.EffectID;
    import game.model.gameObject.constants.EffectTypeID;

    public class EffectDefs implements IEffectDefs
    {
        private var _effectsByID: Vector.<EffectVO>;

        public function EffectDefs(): void
        {
            _effectsByID = new Vector.<EffectVO>();

            //COMPONENTS
            _effectsByID[EffectID.STUN] = new EffectVO(EffectID.STUN, EffectTypeID.COMPONENT, EffectTargetID.HITTED, 0.5);
            _effectsByID[EffectID.KNOCKBACK] = new EffectVO(EffectID.KNOCKBACK, EffectTypeID.COMPONENT, EffectTargetID.HITTED, 0.3, 0.02);
            _effectsByID[EffectID.POISON] = new EffectVO(EffectID.POISON, EffectTypeID.COMPONENT, EffectTargetID.HITTED, 10, 6, 0.8);
            _effectsByID[EffectID.BLACK_HOLE] = new EffectVO(EffectID.BLACK_HOLE, EffectTypeID.COMPONENT, EffectTargetID.HITTED, 10);

            //ACTIONS
            _effectsByID[EffectID.RECHARGE] = new EffectVO(EffectID.RECHARGE, EffectTypeID.ACTION, EffectTargetID.OWNER, 0, 0.8);
            _effectsByID[EffectID.HEAL] = new EffectVO(EffectID.HEAL, EffectTypeID.ACTION, EffectTargetID.OWNER, 0, 0.5);
        }

        public function getEffectVO(aEffectID: uint): EffectVO
        {
            return _effectsByID[aEffectID];
        }
    }
}
