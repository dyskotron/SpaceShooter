package game.model.gameObject.def
{
    import game.model.gameObject.component.effect.EffectVO;

    public interface IEffectDefs
    {
        function getEffectVO(aEffectID: uint): EffectVO;
    }
}
