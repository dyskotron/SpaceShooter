package main.model
{
    import flash.net.SharedObject;
    import flash.utils.Dictionary;

    import game.model.GameModel;

    import org.robotlegs.mvcs.Actor;

    public class MainModel extends Actor implements IMainModel
    {

        private var _numPLayers: uint;
        private var _playerNames: Dictionary;
        private var _playerNamesSO: SharedObject;

        /**
         * Model for storing main view properties and settings
         */
        public function MainModel()
        {
            _playerNames = new Dictionary();
            _playerNamesSO = SharedObject.getLocal("playerNames");

            if (_playerNamesSO.size > 0)
            {
                for (var i: int = 0; i < GameModel.MAX_PLAYERS; i++)
                {
                    _playerNames[i] = _playerNamesSO.data[i];
                }
            }
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

        public function setPlayerName(aPlayerID: uint, aName: String): void
        {
            _playerNamesSO.data[aPlayerID] = aName;
            _playerNamesSO.flush();

            _playerNames[aPlayerID] = aName;
        }


    }
}
