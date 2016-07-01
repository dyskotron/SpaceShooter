package game.model.gameObject.def
{
    import game.model.gameObject.component.weapon.ComponentModel;
    import game.model.playerModel.BuildComponentSlotVO;

    public interface IComponentDefs
    {
        function getComponentModel(aBuildComponentSlotVO: BuildComponentSlotVO): ComponentModel;
    }
}
