package game.model.gameObject.vo
{
    public class GameObjectVO
    {
        private var _typeID: uint;

        private var _width: Number;
        private var _height: Number;

        /**
         * ValueObject holidng definition of GameObject
         * it holds properties which are not changing and are common for a certain type of certain GameObjects
         * @param aTypeID
         * @param aWidth
         * @param aHeight
         */
        public function GameObjectVO(aTypeID: uint, aWidth: Number, aHeight: Number)
        {
            _typeID = aTypeID;
            _width = aWidth;
            _height = aHeight;
        }

        public function get typeID(): uint
        {
            return _typeID;
        }

        public function get width(): Number
        {
            return _width;
        }

        public function get height(): Number
        {
            return _height;
        }
    }
}
