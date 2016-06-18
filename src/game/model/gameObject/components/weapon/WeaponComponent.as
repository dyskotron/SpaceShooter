package game.model.gameObject.components.weapon
{
    import game.model.GameObject;
    import game.model.gameObject.BulletGO;
    import game.model.gameObject.components.Component;
    import game.model.gameObject.components.control.WeaponControlComponent;
    import game.model.gameObject.components.fsm.ITargetProvider;
    import game.model.gameObject.components.weapon.enums.WeaponType;

    import org.osflash.signals.Signal;

    public class WeaponComponent extends Component implements IWeaponComponent
    {

        private var _ownerID: uint;

        private var _weaponModel: WeaponModel;
        private var _nextShotAfter: Number = 0;
        private var _shootSignal: Signal;
        private var _targetProvider: ITargetProvider;


        private var _isShooting: Boolean;
        private var _x: Number = 50;
        private var _y: Number = 0;

        private var _spawnPointIndex: Number = 0;


        public function WeaponComponent(aWeaponModel: WeaponModel, aX: Number = 0, aY: Number = 0)
        {
            _weaponModel = aWeaponModel;
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


        override public function init(aGameObject: GameObject): void
        {
            super.init(aGameObject);

            var weaponControlComponent: WeaponControlComponent = WeaponControlComponent(gameObject.getComponent(WeaponControlComponent));
            if (weaponControlComponent)
            {
                _shootSignal = weaponControlComponent.shootSignal;
                _targetProvider = weaponControlComponent.targetProvider;
            }
            else
                _shootSignal = new Signal(Vector.<BulletGO>);

            _ownerID = gameObject.gameObjectID;


        }

        override public function update(aDeltaTime: int): void
        {
            if (_isShooting)
            {
                _nextShotAfter -= aDeltaTime;

                if (_nextShotAfter <= 0)
                {
                    shoot(gameObject.transform.x + _x, gameObject.transform.y + _y);
                    _nextShotAfter = _weaponModel.shootInterval;
                }
            }
        }

        public function startShoot(aNextShotAfter: Number = 0): void
        {
            _isShooting = true;
            _nextShotAfter = aNextShotAfter;
        }

        public function endShoot(): void
        {
            _isShooting = false;
        }

        public function shoot(aX: Number, aY: Number): void
        {
            var bullets: Vector.<BulletGO> = new Vector.<BulletGO>();

            var spawnPoint: BulletSpawnVO;

            switch (_weaponModel.weaponType)
            {
                case WeaponType.SINGLE:
                    spawnPoint = _weaponModel.spawnPoints[0];
                    bullets.push(new BulletGO(_ownerID, spawnPoint.bulletVO, aX + spawnPoint.x, aY + spawnPoint.y, spawnPoint.speed, spawnPoint.angle, _targetProvider));
                    break;
                case WeaponType.PARALEL:
                    for (var i: int = 0; i < _weaponModel.spawnPoints.length; i++)
                    {
                        spawnPoint = _weaponModel.spawnPoints[i];
                        bullets.push(new BulletGO(_ownerID, spawnPoint.bulletVO, aX + spawnPoint.x, aY + spawnPoint.y, spawnPoint.speed, spawnPoint.angle, _targetProvider));
                    }
                    break;
                case WeaponType.SEQUENTIAL:
                    _spawnPointIndex = (_spawnPointIndex + 1) % _weaponModel.spawnPoints.length;
                    spawnPoint = _weaponModel.spawnPoints[_spawnPointIndex];
                    bullets.push(new BulletGO(_ownerID, spawnPoint.bulletVO, aX + spawnPoint.x, aY + spawnPoint.y, spawnPoint.speed, spawnPoint.angle, _targetProvider));
                    break;
            }

            _shootSignal.dispatch(bullets);
        }
    }
}
