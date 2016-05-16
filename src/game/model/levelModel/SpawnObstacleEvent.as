package game.model.levelModel
{
    import game.model.gameObject.vo.ObstacleVO;

    public class SpawnObstacleEvent extends SpawnLevelEvent
    {
        private var _obstacleVO: ObstacleVO;
        private var _rotation: Number;
        private var _speedX: Number;
        private var _speedY: Number;

        public function SpawnObstacleEvent(aDistance: Number, aObstacleVO: ObstacleVO, aX: Number, aY: Number, aSpeedX: Number, aSpeedY: Number, aRotation: Number)
        {
            _obstacleVO = aObstacleVO;
            _rotation = aRotation;
            _speedX = aSpeedX;
            _speedY = aSpeedY;

            super(LevelEvent.ID_SPAWN_OBSTACLE, aDistance, aX, aY);
        }

        public function get obstacleVO(): ObstacleVO
        {
            return _obstacleVO;
        }

        public function get rotation(): Number
        {
            return _rotation;
        }

        public function get speedX(): Number
        {
            return _speedX;
        }

        public function get speedY(): Number
        {
            return _speedY;
        }
    }
}
