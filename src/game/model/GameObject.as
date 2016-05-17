package game.model
{
    import flash.geom.Rectangle;

    import game.model.gameObject.vo.GameObjectVO;

    public class GameObject
    {
        protected var _gameObjectVO: GameObjectVO;

        protected var _x: Number = 0;
        protected var _y: Number = 0;

        protected var _speedX: Number = 0;
        protected var _speedY: Number = 0;

        protected var _rotation: Number = 0;

        private var _bounds: Rectangle;

        /**
         * base class representing all game objects e.g. player ships enemies bullets etc
         *
         * @param aGameObjectVO - definition for game objects - keep all properties common to all instances of one type
         * @param aX - keeps track of object instance X position
         * @param aY - keeps track of object instance Y position
         * @param aSpeedX - keeps track of object instance X speed
         * @param aSpeedY - keeps track of object instance Y speed
         */
        public function GameObject(aGameObjectVO: GameObjectVO, aX: Number, aY: Number, aSpeedX: Number, aSpeedY: Number)
        {
            _gameObjectVO = aGameObjectVO;

            _x = aX;
            _y = aY;
            _speedX = aSpeedX;
            _speedY = aSpeedY;

            _bounds = new Rectangle(_x - _gameObjectVO.width / 2, _y - _gameObjectVO.height / 2, _gameObjectVO.width, _gameObjectVO.height)
        }

        public function get x(): Number
        {
            return _x;
        }

        public function get y(): Number
        {
            return _y;
        }

        public function get speedX(): Number
        {
            return _speedX;
        }

        public function get speedY(): Number
        {
            return _speedY;
        }

        public function get rotation(): Number
        {
            return _rotation;
        }

        public function get bounds(): Rectangle
        {
            return _bounds;
        }

        public function update(aDeltaTime: int): void
        {
            _bounds.x = _x - _bounds.width / 2;
            _bounds.y = _y - _bounds.height / 2;
        }

        public function destroy(): void
        {

        }

        public function get gameObjectVO(): GameObjectVO
        {
            return _gameObjectVO;
        }
    }
}
