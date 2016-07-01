package game.model.gameObject.vo
{
    public class GameObjectVO
    {
        private var _gameObjectType: uint;

        private var _width: Number;
        private var _height: Number;

        /**
         * ValueObject holding definition of GameObject
         * it holds properties which are not changing and are common for a certain type of certain GameObjects
         * @param aGameObjectType
         * @param aWidth
         * @param aHeight
         */
        public function GameObjectVO(aGameObjectType: uint, aWidth: Number, aHeight: Number)
        {
            _gameObjectType = aGameObjectType;
            _width = aWidth;
            _height = aHeight;
        }

        public function get gameObjectType(): uint
        {
            return _gameObjectType;
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
