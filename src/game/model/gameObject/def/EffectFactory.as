package game.model.gameObject.def
{
    import game.model.GameObject;
    import game.model.gameObject.component.IComponent;
    import game.model.gameObject.component.effect.EffectVO;
    import game.model.gameObject.component.effect.fxComponent.KnockBackEffect;
    import game.model.gameObject.component.effect.fxComponent.PoisonEffect;
    import game.model.gameObject.component.effect.fxComponent.StunEffect;
    import game.model.gameObject.component.movement.MoveParamsComponent;
    import game.model.gameObject.constants.EffectID;

    public class EffectFactory implements IEffectFactory
    {
        [Inject]
        public var bulletDef: IBulletDefs;

        public function EffectFactory()
        {
        }

        public function createEffectComponent(aEffectVO: EffectVO, aBulletGO: GameObject): IComponent
        {
            var effectComponent: IComponent;
            var dmg: Number;

            switch (aEffectVO.effectID)
            {
                case EffectID.STUN:
                    effectComponent = new StunEffect(aEffectVO.length);
                    break;
                case EffectID.KNOCKBACK:
                    var moveParams: MoveParamsComponent = MoveParamsComponent(aBulletGO.getComponent(MoveParamsComponent));
                    effectComponent = new KnockBackEffect(aEffectVO.length, moveParams.speedX * aEffectVO.param1, moveParams.speedY * aEffectVO.param1);
                    break;
                case EffectID.POISON:
                    dmg = bulletDef.getBulletVO(aBulletGO.identity.concreteTypeID).damage;
                    effectComponent = new PoisonEffect(aBulletGO, aEffectVO.length, dmg * aEffectVO.param1, aEffectVO.param2);
                    break;
                case EffectID.BLACK_HOLE:
                    //effectComponent = new BlackHoleEffect(aEffectVO.length, aBulletGO.transform.x, aBulletGO.transform.y);
                    break;

            }

            return effectComponent;
        }
    }
}
