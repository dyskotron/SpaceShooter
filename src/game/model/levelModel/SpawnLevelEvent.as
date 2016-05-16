package game.model.levelModel
{
    public class SpawnLevelEvent extends LevelEvent
    {
        private var _x: Number;
        private var _y: Number;


        public function SpawnLevelEvent(aID: uint, aDistance: Number, aX: Number, aY: Number)
        {
            super(aID, aDistance);

            _x = aX;
            _y = aY;
        }

        public function get x(): Number
        {
            return _x;
        }

        public function get y(): Number
        {
            return _y;
        }
    }
}
