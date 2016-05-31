package game.model.gameObject.vo
{
    public class GameObjectVO
    {
        private var _bulletID: uint;

        private var _width: Number;
        private var _height: Number;

        /**
         * ValueObject holidng definition of GameObject
         * it holds properties which are not changing and are common for a certain type of certain GameObjects
         * @param aBulletID
         * @param aWidth
         * @param aHeight
         */
        public function GameObjectVO(aBulletID: uint, aWidth: Number, aHeight: Number)
        {
            _bulletID = aBulletID;
            _width = aWidth;
            _height = aHeight;
        }

        public function get bulletID(): uint
        {
            return _bulletID;
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
