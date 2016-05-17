package game.model
{
    public interface ILevelProvider
    {
        function getLevel(aDiffulcity: uint = 0): LevelModel
    }

}
