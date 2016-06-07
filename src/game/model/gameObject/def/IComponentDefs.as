package game.model.gameObject.def
{
    import game.model.gameObject.components.weapon.ComponentModel;
    import game.model.playerModel.BuildComponentSlotVO;

    public interface IComponentDefs
    {
        function getComponentModel(aBuildComponentSlotVO: BuildComponentSlotVO): ComponentModel;
    }
}
