package game.model.gameObject
{
    import flash.utils.getTimer;

    import game.model.gameObject.vo.ShootingVO;

    import org.osflash.signals.Signal;

    public class ShootingGO extends HittableGO
    {
        private var _shootSignal: Signal;

        private var _isShooting: Boolean;
        protected var _nextShotTime: Number = 0;
        private var _shootInterval: uint = 200;

        /**
         * Base class for all game objects which are able to shoot
         * @param aShootingVO
         * @param aX
         * @param aY
         * @param aSpeedX
         * @param aSpeedY
         */
        public function ShootingGO(aShootingVO: ShootingVO, aX: Number, aY: Number, aSpeedX: Number = 0, aSpeedY: Number = 0)
        {
            super(aShootingVO, aX, aY, aSpeedX, aSpeedY);

            _shootSignal = new Signal(Vector.<BulletGO>);
            _shootInterval = aShootingVO.shootInterval;
        }

        public function get shootSignal(): Signal
        {
            return _shootSignal;
        }

        public function get shootInterval(): uint
        {
            return _shootInterval;
        }

        override public function update(aDeltaTime: int): void
        {

            if (_isShooting && getTimer() > _nextShotTime)
                shoot();

            super.update(aDeltaTime);
        }

        public function startShoot(): void
        {
            _isShooting = true;
            _nextShotTime = 0;
        }

        public function endShoot(): void
        {
            _isShooting = false;
        }

        protected function shoot(): void
        {
            _nextShotTime = getTimer() + _shootInterval;
        }
    }
}
