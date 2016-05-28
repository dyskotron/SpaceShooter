package game.model.weapon
{
    import flash.utils.getTimer;

    import game.model.gameObject.BulletGO;

    import org.osflash.signals.Signal;

    public class Weapon
    {
        public static const WEAPON_MIN: uint = 1;
        public static const WEAPON_MAX: uint = 10;

        protected var _weaponVO: WeaponVO;
        protected var _nextShotTime: Number = 0;
        protected var _shootSignal: Signal;
        protected var _ownerID: uint;

        private var _isShooting: Boolean;
        private var _x: Number = 0;
        private var _y: Number = 0;


        public function Weapon(aShootSignal: Signal, aWeaponVO: WeaponVO, aOwnerID: uint, aX: Number = 0, aY: Number = 0)
        {
            _shootSignal = aShootSignal;
            _weaponVO = aWeaponVO;
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
            _nextShotTime = getTimer() + _weaponVO.shootInterval;

            var bullets: Vector.<BulletGO> = new Vector.<BulletGO>();

            var spawnPoint: BulletSpawnVO;
            for (var i: int = 0; i < _weaponVO.spawnPoints.length; i++)
            {
                spawnPoint = _weaponVO.spawnPoints[i];
                bullets.push(new BulletGO(_ownerID, _weaponVO.bulletVO, aX + spawnPoint.x, aY + spawnPoint.y, spawnPoint.speedX, spawnPoint.speedY));

            }

            _shootSignal.dispatch(bullets);
        }

    }
}
