package game.model.gameObject
{
    import game.model.gameObject.vo.ObstacleVO;

    public class ObstacleGO extends HittableGO
    {
        private var _speedRotation: Number;
        private var _obstacleVO: ObstacleVO;

        public function ObstacleGO(aObstacleVO: ObstacleVO, aX: Number, aY: Number, aSpeedX: Number = 0, aSpeedY: Number = 0, aSpeedRotation: Number = 0)
        {
            super(aObstacleVO, aX, aY, aSpeedX, aSpeedY);

            _speedRotation = aSpeedRotation;
            _obstacleVO = aObstacleVO;
        }

        override public function update(aDeltaTime: int): void
        {
            rotation += _speedRotation;
            x += speedX * aDeltaTime;
            y += speedY * aDeltaTime;

            super.update(aDeltaTime);
        }

        public function get obstacleVO(): ObstacleVO
        {
            return _obstacleVO;
        }
    }
}
