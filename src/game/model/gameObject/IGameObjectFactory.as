package game.model.gameObject
{
    import game.model.GameObject;
    import game.model.gameObject.components.fsm.ITargetProvider;
    import game.model.playerModel.PlayerShipBuildVO;

    public interface IGameObjectFactory
    {
        function createPlayerShipGO(aPlayerID: uint, aShipBuild: PlayerShipBuildVO, aTargetProvider: ITargetProvider): GameObject
    }
}
