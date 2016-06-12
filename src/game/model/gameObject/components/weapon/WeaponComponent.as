package game.model.gameObject.components.weapon
{
    import game.model.gameObject.BulletGO;
    import game.model.gameObject.components.weapon.enums.WeaponType;

    import org.osflash.signals.Signal;

    public class WeaponComponent implements IWeaponComponent
    {
        private var _weaponModel: WeaponModel;
        protected var _nextShotAfter: Number = 0;
        private var _shootSignal: Signal;
        protected var _ownerID: uint;

        private var _isShooting: Boolean;
        private var _x: Number = 50;
        private var _y: Number = 0;

        private var _spawnPointIndex: Number = 0;


        public function WeaponComponent(aShootSignal: Signal, aWeaponModel: WeaponModel, aOwnerID: uint, aX: Number = 0, aY: Number = 0)
        {
            _shootSignal = aShootSignal;
            _weaponModel = aWeaponModel;
            _weaponModel = aWeaponModel;
            _ownerID = aOwnerID;
            _x = aX;
            _y = aY;
        }

        public function get x(): Number
        {
            return _x;
        }

        public function get y(): Number
        {
            return _y;
        }

        public function get weaponModel(): WeaponModel
        {
            return _weaponModel;
        }

        public function update(aDeltaTime: int, aShipX: Number, aShipY: Number): void
        {
            if (_isShooting)
            {
                _nextShotAfter -= aDeltaTime;

                if (_nextShotAfter <= 0)
                {
                    shoot(aShipX + _x, aShipY + _y);
                    _nextShotAfter = _weaponModel.shootInterval;
                }

                if (_weaponModel.weaponType == WeaponType.SECONDARY)
                    endShoot();
            }
        }

        public function startShoot(): void
        {
            _isShooting = true;
            _nextShotAfter = 0;
        }

        public function endShoot(): void
        {
            _isShooting = false;
        }

        protected function shoot(aX: Number, aY: Number): void
        {
            var bullets: Vector.<BulletGO> = new Vector.<BulletGO>();

            var spawnPoint: BulletSpawnVO;
            switch (_weaponModel.weaponType)
            {
                case WeaponType.SECONDARY:
                case WeaponType.PARALEL:
                    for (var i: int = 0; i < _weaponModel.spawnPoints.length; i++)
                    {
                        spawnPoint = _weaponModel.spawnPoints[i];
                        bullets.push(new BulletGO(_ownerID, spawnPoint.bulletVO, aX + spawnPoint.x, aY + spawnPoint.y, spawnPoint.speedX, spawnPoint.speedY));
                    }
                    break;
                case WeaponType.SEQUENTIAL:
                    _spawnPointIndex = (_spawnPointIndex + 1) % _weaponModel.spawnPoints.length;
                    spawnPoint = _weaponModel.spawnPoints[_spawnPointIndex];
                    bullets.push(new BulletGO(_ownerID, spawnPoint.bulletVO, aX + spawnPoint.x, aY + spawnPoint.y, spawnPoint.speedX, spawnPoint.speedY));
                    break;
            }

            _shootSignal.dispatch(bullets);
        }
    }
}
