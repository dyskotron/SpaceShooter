package game.model.gameObject.def
{
    import game.model.gameObject.vo.ObstacleVO;

    public interface IObstacleDefs
    {
        function getObstacleVO(aObstacleType: uint): ObstacleVO;
    }
}
