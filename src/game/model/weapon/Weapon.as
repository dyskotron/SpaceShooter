package game.model.weapon
{
    import flash.utils.getTimer;

    import org.osflash.signals.Signal;

    public class Weapon
    {
        public static const WEAPON_MIN: uint = 1;
        public static const WEAPON_MAX: uint = 10;

        protected var _shootInterval: uint = 200;
        protected var _nextShotTime: Number = 0;
        protected var _shootSignal: Signal;
        protected var _ownerID: uint;

        private var _isShooting: Boolean;
        private var _x: Number = 0;
        private var _y: Number = 0;


        public function Weapon(aShootSignal: Signal, aShootInterval: int, aOwnerID: uint, aX: Number = 0, aY: Number = 0)
        {
            _shootSignal = aShootSignal;
            _shootInterval = aShootInterval;
            _ownerID = aOwnerID;
            _x = aX;
            _y = aY;
        }

        public function update(aDeltaTime: int, aShipX: Number, aShipY: Number): void
        {
            //TODO: USE DELTA TIME instead of get timer
            if (_isShooting && getTimer() > _nextShotTime)
                shoot(aShipX, aShipY);
        }

        public function startShoot(): void
        {
            _isShooting = true;
        }

        public function stopShoot(): void
        {
            _isShooting = false;
        }

        protected function shoot(aX: Number, aY: Number): void
        {

            //TODO: USE DELTA TIME instead of get timer
            _nextShotTime = getTimer() + _shootInterval;
        }

    }
}
