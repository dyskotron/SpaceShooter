package game.model.gameObject
{
    import game.model.gameObject.vo.ObstacleVO;

    public class ObstacleGO extends HittableGO
    {
        private var _speedRotation: Number;
        private var _obstacleVO: ObstacleVO;
        private var speedX: int;
        private var speedY: int;

        public function ObstacleGO(aObstacleVO: ObstacleVO, aX: Number, aY: Number, aSpeedX: Number = 0, aSpeedY: Number = 0, aSpeedRotation: Number = 0)
        {
            super(aObstacleVO, aX, aY);

            _speedRotation = aSpeedRotation;
            _obstacleVO = aObstacleVO;
            speedX = aSpeedX;
            speedY = aSpeedY;

        }

        override public function update(aDeltaTime: int): void
        {
            transform.rotation += _speedRotation;
            transform.x += speedX * aDeltaTime;
            transform.y += speedY * aDeltaTime;

            super.update(aDeltaTime);
        }

        public function get obstacleVO(): ObstacleVO
        {
            return _obstacleVO;
        }
    }
}
