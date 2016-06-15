package game.model
{
    import flash.geom.Rectangle;

    import game.model.gameObject.components.physics.BasePhysicsComponent;
    import game.model.gameObject.components.physics.IPhysicsComponent;
    import game.model.gameObject.fsm.ITarget;
    import game.model.gameObject.vo.GameObjectVO;

    public class GameObject implements ITarget
    {

        private var _currentTime: int = 0;
        private var _gameObjectVO: GameObjectVO;
        private var _physics: IPhysicsComponent;

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

            //todo: physics factory
            _physics = new BasePhysicsComponent(_gameObjectVO.width, _gameObjectVO.height);
            _physics.x = aX;
            _physics.y = aY;
            _physics.speedX = aSpeedX;
            _physics.speedY = aSpeedY;
        }

        //region ========================================= SETTERS & GETTERS  ==========================================

        public function get physics(): IPhysicsComponent
        {
            return _physics;
        }


        public function get x(): Number
        {
            return _physics.x;
        }

        public function set x(value: Number): void
        {
            _physics.x = value;
        }

        public function get y(): Number
        {
            return _physics.y;
        }

        public function set y(value: Number): void
        {
            _physics.y = value;
        }

        public function get speedX(): Number
        {
            return  _physics.speedX;
        }

        public function set speedX(value: Number): void
        {
            _physics.speedX = value;
        }

        public function get speedY(): Number
        {
            return _physics.speedY;
        }

        public function set speedY(value: Number): void
        {
            _physics.speedY = value;
        }

        public function get rotation(): Number
        {
            return _physics.rotation;
        }

        public function set rotation(value: Number): void
        {
            _physics.rotation = value;
        }

        public function get currentTime(): int
        {
            return _currentTime;
        }

        public function get gameObjectVO(): GameObjectVO
        {
            return _gameObjectVO;
        }

        public function get bounds(): Rectangle
        {
            return _physics.bounds;
        }

        //endregion

        public function update(aDeltaTime: int): void
        {
            _currentTime += aDeltaTime;
            _physics.update(aDeltaTime);
        }

        public function destroy(): void
        {

        }

        public function getAngleFromCoords(aX: Number, aY: Number): Number
        {
            return Math.atan2(physics.x - aX, physics.y - aY);
        }

        public function getAngleDelta(aX: Number, aY: Number, aAngle: Number): Number
        {
            var angleDelta = (Math.PI * 2 + (Math.atan2(physics.x - aX, physics.y - aY) - aAngle)) % (Math.PI * 2);
            if (angleDelta > Math.PI)
                angleDelta = angleDelta - Math.PI * 2;

            return angleDelta;
        }

        public function getDistanceSq(aX: Number, aY: Number): Number
        {
            return Math.pow(physics.x - aX, 2) + Math.pow(physics.y - aY, 2);
        }
    }
}
