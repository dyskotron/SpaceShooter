package game.model.gameObject.def
{
    import game.model.GameObject;
    import game.model.gameObject.component.IComponent;
    import game.model.gameObject.component.effect.EffectVO;

    public interface IEffectFactory
    {
        function createEffectComponent(aEffectVO: EffectVO, aBulletGO: GameObject): IComponent;
    }
}
