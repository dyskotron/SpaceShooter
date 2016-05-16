package home.controller
{

    public class StartGameSignalVO
    {
        private var _numPlayers: uint;

        public function StartGameSignalVO(aNumPlayers: uint): void
        {
            _numPlayers = aNumPlayers;
        }

        public function get numPlayers(): uint
        {
            return _numPlayers;
        }
    }
}