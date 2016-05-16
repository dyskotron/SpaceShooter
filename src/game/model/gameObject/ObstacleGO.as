package game.model.gameObject
{
    import game.model.gameObject.vo.ObstacleVO;

    public class ObstacleGO extends HittableGO
    {
        private var _speedRotation: Number;

        public function ObstacleGO(aObstacleVO: ObstacleVO, aX: Number, aY: Number, aSpeedX: Number = 0, aSpeedY: Number = 0, aSpeedRotation: Number = 0)
        {
            _speedRotation = aSpeedRotation;
            super(aObstacleVO, aX, aY, aSpeedX, aSpeedY);
        }

        override public function update(aDeltaTime: int): void
        {
            _rotation += _speedRotation;
            _x += _speedX * aDeltaTime;
            _y += _speedY * aDeltaTime;

            super.update(aDeltaTime);
        }

        public function get obstacleVO(): ObstacleVO
        {
            return ObstacleVO(_gameObjectVO);
        }
    }
}
