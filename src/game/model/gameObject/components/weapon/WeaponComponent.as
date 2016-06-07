package game.model.gameObject.components.weapon
{
    import game.model.gameObject.BulletGO;
    import game.model.gameObject.components.weapon.enums.WeaponType;

    import org.osflash.signals.Signal;

    public class WeaponComponent implements IWeaponComponent
    {
        protected var _weaponModel: WeaponModel;
        protected var _nextShotAfter: Number = 0;
        private var _shootSignal: Signal;
        protected var _ownerID: uint;

        private var _isShooting: Boolean;
        private var _x: Number = 50;
        private var _y: Number = 0;

        private var _spawnPointIndex: Number = 0;
        private var _indexIncrement: int = 1;
        private var _orientation: int;


        public function WeaponComponent(aShootSignal: Signal, aWeaponModel: WeaponModel, aOwnerID: uint, aX: Number = 0, aY: Number = 0, aOrientation: int = 1)
        {
            _shootSignal = aShootSignal;
            _weaponModel = aWeaponModel;
            _weaponModel = aWeaponModel;
            _orientation = aOrientation;
            _ownerID = aOwnerID;
            _x = aX;
            _orientation = aX >= 0 ? 1 : -1;
            trace("_MO_", this, "CONSTRUCTOR", _orientation, aX);
        }

        public function get x(): Number
        {
            return _x;
        }

        public function get y(): Number
        {
            return _y;
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
            }
        }

        public function startShoot(): void
        {
            _isShooting = true;
            _nextShotAfter = 0;
        }

        public function stopShoot(): void
        {
            _isShooting = false;
        }

        protected function shoot(aX: Number, aY: Number): void
        {
            var bullets: Vector.<BulletGO> = new Vector.<BulletGO>();

            var spawnPoint: BulletSpawnVO;
            switch (_weaponModel.weaponType)
            {
                case WeaponType.PARALEL:
                    for (var i: int = 0; i < _weaponModel.spawnPoints.length; i++)
                    {
                        spawnPoint = _weaponModel.spawnPoints[i];
                        bullets.push(new BulletGO(_ownerID, spawnPoint.bulletVO, aX + spawnPoint.x * _orientation, aY + spawnPoint.y, spawnPoint.speedX * _orientation, spawnPoint.speedY));
                    }
                    break;
                case WeaponType.SEQUENTIAL:
                    _spawnPointIndex += _indexIncrement;


                    //TODO: FIX THIS FOR ONE BULLET GUNS
                    if (_spawnPointIndex < 0)
                    {
                        _spawnPointIndex = 1;
                        _indexIncrement = 1;
                    }
                    else if (_spawnPointIndex > _weaponModel.spawnPoints.length - 1)
                    {
                        _spawnPointIndex = _weaponModel.spawnPoints.length - 2;
                        _indexIncrement = -1;
                    }

                    spawnPoint = _weaponModel.spawnPoints[_spawnPointIndex];
                    bullets.push(new BulletGO(_ownerID, spawnPoint.bulletVO, aX + spawnPoint.x * _orientation, aY + spawnPoint.y, spawnPoint.speedX * _orientation, spawnPoint.speedY));
                    break;
            }

            _shootSignal.dispatch(bullets);
        }
    }
}
