package game.model.gameObject.component.effect
{
    import game.model.GameObject;

    public interface IEffectActionProcessor
    {
        function process(aEffectVO: EffectVO, aTarget: GameObject, aDamage: Number): void;
    }
}
