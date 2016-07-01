package main.model
{
    import game.model.playerModel.IPlayerModel;

    public interface IMainModel
    {
        function get numPlayers(): uint;

        function set numPlayers(value: uint): void;

        function getPlayerName(aPlayerID: uint): String;

        function setPlayerName(aPlayerID: uint, aName: String): void;

        function getPlayerModel(playerID: int): IPlayerModel
    }
}
