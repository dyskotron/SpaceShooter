package game.model.playerModel
{
    public interface IPlayerModel
    {
        function get shipBuild(): PlayerShipBuildVO;

        function get score(): uint;

        function addScore(aScore: uint): void
    }
}
