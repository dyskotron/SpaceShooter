package game.model.levelModel
{
    public class LevelEvent
    {
        public static const ID_SPAWN_ENEMY: uint = 0;
        public static const ID_SPAWN_BONUS: uint = 1;
        public static const ID_SPAWN_OBSTACLE: uint = 2;
        public static const ID_PAUSE: uint = 3;
        public static const ID_END: uint = 4;
        public static const ID_PLAYER_MESSAGE: uint = 5;
        public static const ID_LEVEL_MESSAGE: uint = 6;


        private var _id: uint;
        private var _distance: Number;

        /**
         * BAse class for all events which can occur when player is going trough level
         * @param aID
         * @param aDistance
         */
        public function LevelEvent(aID: uint, aDistance: Number)
        {
            _id = aID;
            _distance = aDistance;
        }

        public function get id(): uint
        {
            return _id;
        }

        public function get distance(): Number
        {
            return _distance;
        }

    }
}
