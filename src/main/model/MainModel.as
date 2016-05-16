package main.model
{
    import flash.utils.Dictionary;

    import org.robotlegs.mvcs.Actor;

    public class MainModel extends Actor implements IMainModel
    {

        private var _numPLayers: uint;
        private var _playerNames: Dictionary;

        /**
         * Model for storing main view properties and settings
         */
        public function MainModel()
        {
            _playerNames = new Dictionary();
        }

        public function get numPlayers(): uint
        {
            return _numPLayers;
        }

        public function set numPlayers(value: uint): void
        {
            _numPLayers = value;
        }

        public function getPlayerName(aPlayerID: uint): String
        {
            return _playerNames[aPlayerID];
        }

        public function setPlayerName(aPlayerID: uint, aName: String): String
        {
            return _playerNames[aPlayerID] = aName;
        }


    }
}
