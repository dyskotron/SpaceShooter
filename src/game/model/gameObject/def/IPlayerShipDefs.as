package game.model.gameObject.def
{
    import game.model.gameObject.PlayerShipGO;
    import game.model.gameObject.fsm.ITargetProvider;
    import game.model.gameObject.vo.PlayerShipVO;
    import game.model.playerModel.PlayerShipBuildVO;

    public interface IPlayerShipDefs
    {
        function playerGameObjectFactory(aPlayerID: int, aShipBuild: PlayerShipBuildVO, aTargetProvider: ITargetProvider): PlayerShipGO;

        function getPlayerShipVO(aShipBuild: PlayerShipBuildVO): PlayerShipVO
    }
}
