package main.model
{
    public interface IMainModel
    {
        function get numPlayers(): uint;

        function set numPlayers(value: uint): void;

        function getPlayerName(aPlayerID: uint): String;

        function setPlayerName(aPlayerID: uint, aName: String): void;
    }
}
