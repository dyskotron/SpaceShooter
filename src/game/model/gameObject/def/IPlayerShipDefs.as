package game.model.gameObject.def
{
    import game.model.gameObject.vo.PlayerShipVO;
    import game.model.playerModel.PlayerShipBuildVO;

    public interface IPlayerShipDefs
    {
        function getPlayerShipVO(aShipBuild: PlayerShipBuildVO): PlayerShipVO
    }
}
